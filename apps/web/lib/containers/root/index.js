import React, { Component } from 'react'
import Recurring from '../../pages/recurring'
import Expenses from '../../pages/expenses'
import { connect } from 'react-redux'

const PAGE_MAP = { Recurring, Expenses }

class Root extends Component {
	render () {
		const Page = PAGE_MAP[this.props.pageType]
		return <Page {...this.props.pageProps.toObject()} />
	}
}

export default connect((state) => state.app.toObject())(Root)
