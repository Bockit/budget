import { Map, fromJS } from 'immutable'

// Default to posts page
const initialState = Map({
	pageType: 'Overview',
	pageProps: Map(),
})

const handlers = {
	'PAGE:SET': setPage,
}

export default function appReducer (state = initialState, action) {
	if (!handlers[action.type]) return state
	return handlers[action.type](state, action)
}

export function setPage (state, action) {
	return state
		.set('pageType', action.pageType)
		.set('pageProps', fromJS(action.pageProps || {}))
}

