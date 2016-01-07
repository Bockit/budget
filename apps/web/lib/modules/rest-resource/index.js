import request from 'request'

const defaults = {
	idAttribute: 'id',
}

export default class RestResource {
	constructor (resources, options = {}) {
		this.cached = {}
		this.options = Object.assign({}, defaults, options)

		resources.forEach(this.cache.bind(this))
	}

	cache (resource) {
		this.cached[resource[this.options.idAttribute]] = resource
		return resource
	}

	get (id) {
		return new Promise((resolve, reject) => {
			if (this.cached[id]) resolve(this.cached[id])
			const uri = `${this.options.urlBase}/${id}`
			request({ uri, json: true }, (err, res, resource) => {
				if (err) return reject(err)
				resolve(this.cache(resource))
			})
		})
	}

	getRange (offset = 0, limit = 10) {
		return new Promise((resolve, reject) => {
			const query = `?offset=${offset}&limit=${limit}`
			const uri = `${this.options.urlBase}${query}`
			request({ uri, json: true }, (err, res, resources) => {
				if (err) return reject(err)
				resources.forEach(this.cache.bind(this))
				resolve(resources)
			})
		})
	}

	clearCache (id = null) {
		if (id) {
			delete this.cache[id]
			return
		}
		this.cache = {}
	}
}
