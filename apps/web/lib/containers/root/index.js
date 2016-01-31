import React, { Component } from 'react'
import Overview from '../../pages/overview'
import Recurrings from '../../pages/recurrings'
import Transactions from '../../pages/transactions'
import { connect } from 'react-redux'

const PAGE_MAP = { Overview, Recurrings, Transactions }

class Root extends Component {
	render () {
		const Page = PAGE_MAP[this.props.pageType]

		return <Page {...this.props.pageProps.toObject()} />
	}
}

export default connect((state) => state.app.toObject())(Root)
