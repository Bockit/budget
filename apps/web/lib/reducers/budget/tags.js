import { Map, List } from 'immutable'

// Default to posts page
const initialState = Map({
	tags: List(),
	loading: true,
})

const handlers = {
	'TAGS:LOAD': loadTags,
	'TAGS:ADD': addTags,
}

export default function modalReducer (state = initialState, action) {
	if (!handlers[action.type]) return state
	return handlers[action.type](state, action)
}

export function loadTags (state, action) {
	return state.set('tags', List(action.tags))
		.set('loading', false)
}

export function addTags (state, action) {
	if (!state.get('tags').contains(tag)) {
		state = state.put('tags', List.push(action.tag))
	}
	return state
}
