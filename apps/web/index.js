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
// import { devTools } from 'redux-devtools'
// import renderDevTools from './lib/modules/dev-tools-window'
/* eslint no-unused-vars: 0 */
import styles from './index.css'

// const DEBUG_SESSION = /[?&]debug_session=([^&]+)\b/


function App (settings, initialState) {
	for (const key in initialState) {
		initialState[key] = fromJS(initialState[key])
	}

	const middleware = [ applyMiddleware(thunk) ]
	// if (process.env.NODE_ENV !== 'production') {
	// 	middleware.push(devTools())
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
			<Root />
		</Provider>
	), document.getElementById('root'))

	function makeUri (location) {
		return location.pathname + location.search + location.hash
	}
}

// Workaround for babel exports.default not working with umd
module.exports = App

// Workaround for HMR breaking standalone
const { settings, initialState } = window.__budget
delete window.__budget
App(settings, initialState)

if (process.env !== 'production' && module.hot) {
	module.hot.unaccepted(() => setTimeout(() => {
		window.location.reload()
	}, 2000))
	module.hot.decline()
}
