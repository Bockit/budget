import { Map, fromJS } from 'immutable'

// Default to posts page
const initialState = Map({
	modal: null,
})

const handlers = {
	'MODAL:SHOW': showModal,
	'MODAL:HIDE': hideModal,
}

export default function modalReducer (state = initialState, action) {
	if (!handlers[action.type]) return state
	return handlers[action.type](state, action)
}

export function showModal (state, action) {
	return state
		.set('modal', action.modal)
		.set('data', fromJS(action.data || {}))
}

export function hideModal () {
	return state
		.set('modal', null)
		.delete('data')
}
