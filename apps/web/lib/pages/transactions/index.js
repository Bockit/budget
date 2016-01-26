import React, { Component } from 'react'
import { connect } from 'react-redux'

class TransactionsPage extends Component {
	render () {
		return (
			<b>Expenses</b>
		)
	}
}

export default connect()(TransactionsPage)
