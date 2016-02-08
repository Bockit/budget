import * as loading from './loading'
import * as mutations from '../../modules/graphql/mutations'
import * as queries from '../../modules/graphql/queries'

export function showTransactionModal (transaction) {
	return {
		type: 'MODAL:SHOW',
		modal: 'Transaction',
		data: transaction,
	}
}

function doAsyncSingle (fn, { id, dispatch, success }) {
	dispatch(loading.start('TRANSACTION', 'single', { id }))

	return fn()
		.then(success)
		.then(() => dispatch(loading.stop('TRANSACTION', 'single', { id })))
		.then(null, (error) => {
			dispatch(loading.error('TRANSACTION', 'single', { id, error }))
		})
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
			transactions.forEach((transaction) => {
				transaction.tags = transaction.tags.map((tag) => tag.tag)
			})
			dispatch({
				type: 'TRANSACTION:ADD',
				transactions,
				offset,
				limit,
			})
		}

		dispatch(loading.start('TRANSACTION', 'range', { offset, limit }))

		return queries.getTransactions(offset, limit)
			.then(success)
			.then(() => {
				dispatch(loading.stop('TRANSACTION', 'range', { offset, limit }))
			})
			.then(null, (error) => {
				const props = { offset, range }
				dispatch(loading.error('TRANSACTION', 'range', error, props))
			})
	}
}
