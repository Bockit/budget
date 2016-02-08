import { List, fromJS } from 'immutable'
import union from '../../modules/immutable/union'

// Default to posts page
const initialState = List()

const handlers = {
	'TRANSACTION:ADD': addTransactions,
}

export default function transactionReducer (state = initialState, action) {
	if (!handlers[action.type]) return state
	return handlers[action.type](state, action)
}

export function addTransactions (state, action) {
	const incoming = fromJS(action.transactions)
	return union(state, incoming)
}

