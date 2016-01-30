import React from 'react'
import { renderToString } from 'react-dom/server'
import { Provider } from 'react-redux'
import { createStore, applyMiddleware, compose } from 'redux'
import thunk from 'redux-thunk'
import reducer from './lib/reducers/budget'
import Router from './lib/modules/router'
import Root from './lib/containers/root'

export default function App (settings, url, callback) {
	const middleware = applyMiddleware(thunk)
	const store = compose(middleware)(createStore)(reducer)

	const router = new Router(store)
	router.process(url)

	const content = renderToString(
		<Provider store={store}>
			<Root />
		</Provider>
	)

	const initialState = store.getState()
	for (const key in initialState) {
		initialState[key] = initialState[key].toJS()
	}

	callback(null, { content, initialState })
}
