export default function renderFactory (tmpl, app, settings) {
	return function render (req, res) {
		app(settings, req.url, (err, { content, initialState }) => {
			if (err) return res.status(500, err.stack)
			res.status(200).send(tmpl({ settings, content, initialState }))
		})
	}
}
