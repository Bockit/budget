import request from 'request'

const uri = 'http://localhost:4000/api'
const headers = { 'Content-Type': 'application/x-www-form-urlencoded' }
const method = 'POST'

export default function graphQlRequest (query) {
	return new Promise((resolve, reject) => {
		const body = `query=${encodeURIComponent(query)}`
		request({ uri, method, headers, body }, (err, resp) => {
			if (err) return reject(err)

			try {
				resolve(JSON.parse(resp.body))
			}
			catch (exception) {
				reject(exception)
			}
		})
	}).then(({ data }) => data)
}
