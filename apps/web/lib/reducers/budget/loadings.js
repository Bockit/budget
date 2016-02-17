import { Map } from 'immutable'

// Default to posts page
const initialState = Map({
	TRANSACTION: Map({
		single: Map(),
		range: Map(),
	}),
	RECURRING: Map({
		single: Map(),
		range: Map(),
	}),
})

const handlers = {
	'TRANSACTION:LOADING:START': start('TRANSACTION'),
	'TRANSACTION:LOADING:STOP': stop('TRANSACTION'),
	'TRANSACTION:LOADING:ERROR': error('TRANSACTION'),
	'RECURRING:LOADING:START': start('RECURRING'),
	'RECURRING:LOADING:STOP': stop('RECURRING'),
	'RECURRING:LOADING:ERROR': error('RECURRING'),
}

export default function modalReducer (state = initialState, action) {
	if (!handlers[action.type]) return state
	return handlers[action.type](state, action)
}

export function start (type) {
	return function doStart (state, action) {
		const key = readKeyFromAction(action)
		state.setIn([ type, operation, key ], 'loading')
	}
}

export function stop (type) {
	return function doStop (state, action) {
		const key = readKeyFromAction(action)
		state.deleteIn([ type, operation, key ])
	}
}

export function error (type) {
	return function doError (state, action) {
		const key = readKeyFromAction(action)
		state.setIn([ type, operation, key ], 'error')
	}
}

function readKeyFromAction (action) {
	if (action.operation === 'single') {
		return action.id || 'create'
	}

	if (action.operation === 'range') {
		const { offset, limit } = action
		return `{offset}-${offset + limit - 1}`
	}

	throw new Error(```
		You have selected an unsupported loading operation. Currently supported
		operations are 'single' and 'range'.
	```)
}
