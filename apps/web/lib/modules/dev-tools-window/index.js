// Courtesy of
// https://gist.github.com/tlrobinson/1e63d15d3e5f33410ef7#gistcomment-1586968

import React from 'react'
import ReactDom from 'react-dom'
import { DevTools, DebugPanel, LogMonitor } from 'redux-devtools/lib/react'

const PAGE_OPTIONS = [
	[ 'menubar', 'no' ],
	[ 'location', 'no' ],
	[ 'resizable', 'yes' ],
	[ 'scrollbars', 'no' ],
	[ 'status', 'no' ],
]

export default function createDevToolsWindow (store) {
	// give it a name so it reuses the same window
	const name = 'redux-devtools'
	const options = PAGE_OPTIONS.map((opt) => opt.join('=')).join(',')
	const win = window.open(null, name, options)

	if (!win) {
		/* eslint no-console: 0 */
		console.warn(`Redux dev tools disabled due to blocking popups.
			Please allow popups to use the dev tools`)
	}

	// reload in case it's reusing the same window with the old content
	win.location.reload()

	// wait a little bit for it to reload, then render
	setTimeout(() => {
		// Wait for the reload to prevent:
		// "Uncaught Error: Invariant Violation: _registerComponent(...):
		// Target container is not a DOM element."
		win.document.write('<div id="react-devtools-root"></div>')

		ReactDom.render((
			<DebugPanel top right bottom left key="debugPanel">
				<DevTools store={store} monitor={LogMonitor} />
			</DebugPanel>
		), win.document.getElementById('react-devtools-root'))
	}, 4)
}
