import { env as argv } from 'gulp-util'
let env = argv.env || argv.e || 'development'
process.env.NODE_ENV = env

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

let isProduction = env === 'staging' || env === 'production'
let error = errorFactory({ notifications: config.get('notifications.error') })
let appPort = argv.port || argv.p || config.get('server.port')
let lrPort = argv.livereload || argv.lr || config.get('server.livereload')
let dest = stringBuilder('build/')

let triggerLr = triggerFactory({ port: lrPort })
let reloadAll = triggerLr.bind(null, 'all')
let reloadCss = triggerLr.bind(null, 'css')
let copyStatic = staticFactory({ error })
let serve = serveFactory({ error })
let startLr = livereloadFactory({ error })

var postCss = [
	nested,
	Core.values,
	Core.localByDefault,
	Core.extractImports,
	Core.scope,
]

let transforms = [ 'babelify' ]
if (isProduction) transforms.push('envify')
let bundleSettings = {
	error,
	transforms,
	onUpdate: reloadAll,
	buildNotifications: config.get('notifications.build'),
	browserifyOptions: {
		standalone: 'App',
	},
	plugins: [ {
		plugin: cssModulesify,
		opts: {
			rootDir: __dirname,
			output: dest(env) + '/index.css',
			use: postCss,
			after: [ autoprefixer({
				browsers: [ 'last 2 versions', 'IE >= 9' ],
				remove: false,
			}) ],
		},
	} ],
}
if (isProduction) bundleSettings.ignores = [ 'redux-devtools' ]
let bundle = bundleFactory(bundleSettings)

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
	startLr(lrPort)
	serve(dest(env), { port: appPort, lrPort: lrPort })
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
