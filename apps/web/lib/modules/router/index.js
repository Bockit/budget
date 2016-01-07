import SimpleRouter from '@bockit/simple-router'
import { setPostsPage, setPostPage, fetchAuthors } from '../../actions/blog'

function noop () {}

export default class Router extends SimpleRouter {
	constructor (store) {
		super()

		this.store = store
	}
}
