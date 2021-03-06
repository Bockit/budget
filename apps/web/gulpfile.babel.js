import { env as argv } from 'gulp-util'
const env = process.env.NODE_ENV = process.env.NODE_ENV || 'development'

import bundleFactory from '@bockit/bundle'
import staticFactory from '@smallmultiples/static'
import serveFactory from '@smallmultiples/serve'
import livereloadFactory from '@smallmultiples/livereload'
import triggerFactory from '@smallmultiples/livereload/trigger'
import errorFactory from '@smallmultiples/gulp-error-logger'
import stringBuilder from '@smallmultiples/string-builder'
import ncalls from '@smallmultiples/ncalls'
import gulp from 'gulp'
import rimraf from 'rimraf'
import config from 'config'
import cssModulesify from 'css-modulesify'
import eslint from 'gulp-eslint'
import Core from 'css-modules-loader-core'
import nested from 'postcss-nested'
import autoprefixer from 'autoprefixer'
import browserifyHmr from 'browserify-hmr'
import fs from 'fs'

const isProduction = env === 'staging' || env === 'production'
const error = errorFactory({ notifications: config.get('notifications.error') })
const appPort = argv.port || argv.p || config.get('server.port')
const hmrPort = argv.hmr || config.get('server.hmr')
const lrPort = argv.livereload || argv.lr || config.get('server.livereload')
const dest = stringBuilder('build/')

const copyStatic = staticFactory({ error })
const serve = serveFactory({ error })
const reloadCss = triggerFactory({ port: lrPort }).bind(null, 'css')
const startLr = livereloadFactory({ error })

var postCss = [
	nested,
	Core.values,
	Core.localByDefault,
	Core.extractImports,
	Core.scope,
]

Core.scope.generateScopedName = (name, filename) => {
	var sanitisedPath = filename.replace(/\.[^\.\/\\]+$/, '')
		.replace(/[\W_]+/g, '_')
		.replace(/^_|_$/g, '')
	return `_web_${sanitisedPath}__${name}`
}

const transforms = [ 'babelify' ]
if (isProduction) transforms.push('envify')
const bundleSettings = {
	error,
	transforms,
	buildNotifications: config.get('notifications.build'),
	browserifyOptions: {
		standalone: 'App',
		fullPaths: argv['full-paths'],
	},
	plugins: [
		{
			plugin: cssModulesify,
			opts: {
				rootDir: __dirname,
				output: `${dest(env)}/index.css`,
				jsonOutput: `${dest(env)}/css-modules.manifest.json`,
				use: postCss,
				after: [ autoprefixer({
					browsers: [ 'last 2 versions', 'IE >= 9' ],
					remove: false,
				}) ],
			},
		},
	],
}
if (isProduction) bundleSettings.ignores = [ 'redux-devtools' ]
if (!isProduction) {
	bundleSettings.plugins.push({
		plugin: browserifyHmr,
		opts: {
			mode: 'websocket',
			port: hmrPort,
			url: `http://127.0.0.1:${hmrPort}`,
		},
	})
}
const bundle = bundleFactory(bundleSettings)

// Clean the build folder
gulp.task('clean', (next) => rimraf(dest(env), next))

// Build and exit
gulp.task('build', [ 'lint', 'clean' ], (next) => {
	next = ncalls(3, next)
	fs.mkdirSync(dest(env))
	bundle('index.js', dest(env), {
		debug: !isProduction,
		minify: isProduction,
		once: true,
	}, next)
	copyStatic('static/**/*', dest(env), { base: './static' }, next)
})

// Build and start watching for changes
gulp.task('default', [ 'lint', 'clean' ], () => {
	fs.mkdirSync(dest(env))
	bundle('index.js', dest(env), {
		debug: !isProduction,
		minify: isProduction,
	}, () => watchCss())
	copyStatic('static/**/*', dest(env), { base: './static' })

	watchJs()
	startLr()
	serve(dest(env), { port: appPort })
})

gulp.task('lint', lint)

function lint (done) {
	gulp.src([ 'index.js', 'server.js', 'lib/**/*.js' ])
		.pipe(eslint())
		.pipe(eslint.format())
		.resume()
		.on('end', done)
}

function watchJs () {
	gulp.watch([ './index.js', './server.js', './lib/**/*.js' ], [ 'lint' ])
}

function watchCss () {
	gulp.watch([ `${dest(env)}/index.css` ], reloadCss)
}
