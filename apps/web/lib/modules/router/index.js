import SimpleRouter from '@bockit/simple-router'
import {
	setOverviewPage,
	setTransactionsPage,
	setRecurringsPage,
} from '../../actions/budget/page-changes'

function handleAction (promise, callback) {
	function success (...args) {
		if (callback) callback(null, ...args)
	}

	function failure (err) {
		if (callback) callback(err)
	}

	promise.then(success, failure)
}

export default class Router extends SimpleRouter {
	constructor (store) {
		super()
		this.store = store

		this.route('/', this.overview.bind(this))
		this.route('/transactions', this.transactions.bind(this))
		this.route('/recurrings', this.recurrings.bind(this))
	}

	overview (req, callback) {
		const promise = this.store.dispatch(setOverviewPage())
		handleAction(promise, callback)
	}

	transactions (req, callback) {
		const promise = this.store.dispatch(setTransactionsPage())
		handleAction(promise, callback)
	}

	recurrings (req, callback) {
		const promise = this.store.dispatch(setRecurringsPage())
		handleAction(promise, callback)
	}
}
