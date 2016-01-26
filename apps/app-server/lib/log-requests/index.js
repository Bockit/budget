/* eslint no-console: 0 */
export default function logRequests ({ logger = console.log }) {
	return function (req, res, next) {
		logger(`${req.method} ${req.originalUrl}`)
		next()
	}
}
