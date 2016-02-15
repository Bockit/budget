import logger from '../logger'
import error from './error'

export default function renderFactory (tmpl, app, settings) {
	return function render (req, res) {
		app(settings, req.url, (err, state = {}) => {
			if (err) {
				logger.error(
					'Error: %s',
					err.stack || err.message || err,
					{ error: err }
				)
				return res.status(500).send(error(err))
			}

			const { content, initialState } = state
			res.status(200).send(tmpl({ settings, content, initialState }))
		})
	}
}
