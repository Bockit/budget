import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore, applyMiddleware, compose } from 'redux'
import thunk from 'redux-thunk'
import { fromJS } from 'immutable'
import popState from 'popstate'
import reducer from './lib/reducers/budget'
import Router from './lib/modules/router'
import Root from './lib/containers/root'
// import { devTools, persistState } from 'redux-devtools'
// import renderDevTools from './lib/modules/dev-tools-window'
import styles from './index.css'

// const DEBUG_SESSION = /[?&]debug_session=([^&]+)\b/

export default function App (settings, initialState) {
	for (const key in initialState) {
		initialState[key] = fromJS(initialState[key])
	}

	const middleware = [ applyMiddleware(thunk) ]
	// if (process.env.NODE_ENV !== 'production') {
	// 	middleware.push(devTools())
	// 	const stateId = window.location.href.match(DEBUG_SESSION)
	// 	middleware.push(persistState(stateId))
	// }
	const store = compose(...middleware)(createStore)(reducer, initialState)

	const router = new Router(store)
	popState((event) => {
		if (router.process(makeUri(window.location))) event.preventDefault()
	})
	router.process(makeUri(window.location))

	// if (process.env.NODE_ENV !== 'production') renderDevTools(store)

	render((
		<Provider store={store}>
			<Root className={styles.root} />
		</Provider>
	), document.querySelector('.root'))

	function makeUri (location) {
		return location.pathname + location.search + location.hash
	}
}
