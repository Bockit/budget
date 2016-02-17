import { Map, List, fromJS } from 'immutable'
import union from '../../modules/immutable/union'

// Default to posts page
const initialState = Map({
	all: List(),
	byId: Map(),
})

const handlers = {
	'TRANSACTION:ADD': addTransactions,
}

export default function transactionReducer (state = initialState, action) {
	if (!handlers[action.type]) return state
	return handlers[action.type](state, action)
}

export function addTransactions (state, action) {
	const incoming = fromJS(action.transactions)
	state = state.set('all', union(state, incoming))
	state = state.set('byId', byId(state.get('all')))
}

function byId (list) {
	return Map(list.reduce((map, transaction) => {
		map[transaction.get('id')] = transaction
		return map
	}, {}))
}
