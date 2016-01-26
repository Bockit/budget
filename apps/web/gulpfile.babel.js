import { env as argv } from 'gulp-util'
const env = argv.env || argv.e || 'development'
process.env.NODE_ENV = env

import bundleFactory from '@bockit/bundle'
import staticFactory from '@smallmultiples/static'
import serveFactory from '@smallmultiples/serve'
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

const isProduction = env === 'staging' || env === 'production'
const error = errorFactory({ notifications: config.get('notifications.error') })
const appPort = argv.port || argv.p || config.get('server.port')
const lrPort = argv.livereload || argv.lr || config.get('server.livereload')
const dest = stringBuilder('build/')

const copyStatic = staticFactory({ error })
const serve = serveFactory({ error })

var postCss = [
	nested,
	Core.values,
	Core.localByDefault,
	Core.extractImports,
	Core.scope,
]

const transforms = [ 'babelify' ]
if (isProduction) transforms.push('envify')
const bundleSettings = {
	error,
	transforms,
	onUpdate: () => {},
	buildNotifications: config.get('notifications.build'),
	browserifyOptions: {
		standalone: 'App',
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
			port: lrPort,
			url: `http://127.0.0.1:${lrPort}`,
		},
	})
}
const bundle = bundleFactory(bundleSettings)

// Clean the build folder
gulp.task('clean', (next) => rimraf(dest(env), next))

// Build and exit
gulp.task('build', [ 'lint', 'clean' ], (next) => {
	next = ncalls(3, next)
	bundle('index.js', dest(env), {
		debug: !isProduction,
		minify: isProduction,
		once: true,
	}, next)
	copyStatic('static/**/*', dest(env), { base: './static' }, next)
})

// Build and start watching for changes
gulp.task('default', [ 'lint', 'clean' ], () => {
	bundle('index.js', dest(env), {
		debug: !isProduction,
		minify: isProduction,
	})
	copyStatic('static/**/*', dest(env), { base: './static' })

	watchJs()
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
