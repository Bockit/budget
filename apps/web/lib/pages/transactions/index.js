import React, { Component } from 'react'
import { connect } from 'react-redux'
import Nav from '../../components/nav'

class TransactionsPage extends Component {
	render () {
		return (
			<header>
				<Nav active="transactions" />
				<b>Transactions</b>
			</header>
		)
	}
}

export default connect()(TransactionsPage)
