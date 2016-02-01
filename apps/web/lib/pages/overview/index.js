import React, { Component } from 'react'
import { connect } from 'react-redux'
import Nav from '../../containers/nav'
import CreateTransactionButton from '../../containers/create-transaction-button'

class OverviewPage extends Component {
	render () {
		return (
			<header>
				<Nav>
					<CreateTransactionButton />
				</Nav>
			</header>
		)
	}
}

export default connect()(OverviewPage)
