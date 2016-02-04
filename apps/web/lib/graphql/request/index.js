import request from 'request'

const uri = 'http://localhost:4200/api'
const headers = { 'Content-Type': 'application/graphql' }

export default function graphQlRequest (body) {
	return request({ uri, headers, body })
}
