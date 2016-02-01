import SimpleRouter from '@bockit/simple-router'
import {
	setOverviewPage,
	setTransactionsPage,
	setRecurringsPage,
} from '../../actions/budget/page-changes'

export default class Router extends SimpleRouter {
	constructor (store) {
		super()
		this.store = store

		this.route('/', () => setOverviewPage())
		this.route('/transactions', () => setTransactionsPage())
		this.route('/recurrings', () => setRecurringsPage())
	}
}
