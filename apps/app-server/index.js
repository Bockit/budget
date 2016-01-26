require('babel/register')
const hook = require('css-modules-require-hook')
const autoprefixer = require('autoprefixer')
const nested = require('postcss-nested')

hook({
	prepend: [ nested ],
	append: [ autoprefixer({
		browsers: [ 'last 2 versions', 'IE >= 9' ],
		remove: false,
	}) ],
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
