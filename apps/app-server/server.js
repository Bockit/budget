import express from 'express'
import config from 'config'
import logger from './lib/logger'
import render from './lib/render'
import logRequests from './lib/log-requests'
import webapp from '@bockit/jameshiscock.com-webapp/server'
import webappTemplate from '@bockit/jameshiscock.com-webapp/index.jade'

const settings = config.get('appSettings')
const port = config.get('server.port')
const hostname = config.get('server.hostname')

logger.info('Creating app')
const app = express()

app.use(logRequests({ logger: logger.info.bind(logger) }))
app.get('*', render(webappTemplate, webapp, settings))

logger.info('Starting server')
app.listen(port, hostname, (err) => {
	if (err) {
		return logger.error(
			'Error: %s',
			err.stack || err.message || err,
			{ error: err }
		)
	}
	logger.info('Server listening on %s:%s', hostname, port)
})
