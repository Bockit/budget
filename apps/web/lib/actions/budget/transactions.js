import * as mutations from '../../modules/graphql/mutations'
import * as queries from '../../modules/graphql/queries'

export function showTransactionModal (transaction) {
	return {
		type: 'MODAL:SHOW',
		modal: 'Transaction',
		data: transaction,
	}
}

export function startLoading (operation, props) {
	return {
		type: 'TRANSACTION:LOADING:START',
		operation,
		...props,
	}
}

export function stopLoading (operation, props) {
	return {
		type: 'TRANSACTION:LOADING:STOP',
		operation,
		...props,
	}
}

export function errorLoading (operation, error, props) {
	return {
		type: 'TRANSACTION:LOADING:ERROR',
		operation,
		error,
		...props,
	}
}

function doAsyncSingle (fn, { id, dispatch, success }) {
	dispatch(startLoading('single', { id }))

	return fn()
		.then(success)
		.then(() => dispatch(stopLoading('single', { id })))
		.then(null, (error) => dispatch(errorLoading('single', { id, error })))
}

export function addTagToTransaction (id, tag) {
	return (dispatch) => {
		const success = dispatch.bind(null, {
			type: 'TRANSACTION:TAGS:ADD',
			tags: [ tag ],
			id,
		})

		return doAsyncSingle(() => {
			return mutations.addTagsToTransaction(id, [ tag ])
		}, { id, dispatch, success })
	}
}

export function removeTagFromTransaction (id, tag) {
	return (dispatch) => {
		const success = dispatch.bind(null, {
			type: 'TRANSACTION:TAGS:REMOVE',
			tags: [ tag ],
			id,
		})

		return doAsyncSingle(() => {
			return mutations.removeTagsFromTransaction(id, [ tag ])
		}, { id, dispatch, success })
	}
}

export function updateTransaction (id, field, value) {
	return (dispatch) => {
		const success = dispatch.bind(null, {
			type: 'TRANSACTION:UPDATE',
			id,
			props: {
				[field]: value,
			},
		})

		return doAsyncSingle(() => {
			return mutations.updateTransaction(id, field, value)
		}, { id, dispatch, success })
	}
}

export function createTransaction (transaction) {
	return (dispatch) => {
		const success = dispatch.bind(null, {
			type: 'TRANSACTION:CREATE',
			transaction,
		})

		return doAsyncSingle(() => {
			return mutations.createTransaction(transaction)
		}, { id, dispatch, success })
	}
}

export function loadTransactions (offset, limit) {
	return (dispatch) => {
		function success ({ transactions }) {
			dispatch({
				type: 'TRANSACTION:ADD',
				transactions,
				offset,
				limit,
			})
		}

		dispatch(startLoading('range', { offset, limit }))

		return queries.getTransactions(offset, limit)
			.then(success)
			.then(() => dispatch(stopLoading('range', { offset, limit })))
			.then(null, (error) => {
				dispatch(errorLoading('range', { offset, range, error }))
			})
	}
}
