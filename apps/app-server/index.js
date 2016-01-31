require('babel-register')({ ignore })
const hook = require('css-modules-require-hook')
const nested = require('postcss-nested')

hook({
	prepend: [ nested ],
})

var jade = require('jade')
var resolvedJade = require.resolve('jade')

function compileTemplate (module, filename) {
	var template = jade.compileFileClient(filename, { externalRuntime: true })
	/* eslint prefer-template: 0 */
	var body = 'var jade = require(\'' + resolvedJade + '\').runtime;\n\n' +
		'module.exports = ' + template + ';'
	module._compile(body, filename)
}

if (require.extensions) require.extensions['.jade'] = compileTemplate

require('./server')

function ignore (filename) {
	var web = 'apps/web'
	var webModules = web + '/node_modules'
	var simpleRouter = webModules + '/@bockit/simple-router'
	var simpleRouterModules = simpleRouter + '/node_modules'

	web = new RegExp(web)
	webModules = new RegExp(webModules)
	simpleRouter = new RegExp(simpleRouter)
	simpleRouterModules = new RegExp(simpleRouterModules)

	if (simpleRouterModules.test(filename)) return true
	if (simpleRouter.test(filename)) return false
	if (webModules.test(filename)) return true
	if (web.test(filename)) return false

	return /node_modules\//.test(filename)
}
