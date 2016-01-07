import RestResource from '../modules/rest-resource'

export const posts = new RestResource([], {
	urlBase: 'http://127.0.0.1:3030/api/posts',
})

export const users = new RestResource([], {
	urlBase: 'http://127.0.0.1:3030/api/users',
})
