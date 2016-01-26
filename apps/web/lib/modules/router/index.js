import SimpleRouter from '@bockit/simple-router'

export default class Router extends SimpleRouter {
	constructor (store) {
		super()
		this.store = store
	}
}
