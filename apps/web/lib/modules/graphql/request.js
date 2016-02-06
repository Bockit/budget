import request from 'request'

const uri = 'http://localhost:4000/api'
const headers = { 'Content-Type': 'application/graphql' }

export default function graphQlRequest (body) {
	return new Promise((resolve, reject) => {
		request({ uri, headers, body }, (err, resp) => {
			if (err) return reject(err)

			try {
				resolve(JSON.parse(resp))
			}
			catch (exception) {
				reject(exception)
			}
		}).then(({ data }) => data)
	})
}
