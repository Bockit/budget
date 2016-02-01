import React, { Component } from 'react'
import { connect } from 'react-redux'
import { showTransactionModal } from '../../actions/budget/transactions'
import Button from '../../components/button'

class CreateTransactionButton extends Component {
	render () {
		const onClick = this.props.dispatch.bind(null, showTransactionModal())
		return <Button onClick={onClick}>New Transaction</Button>
	}
}

export default connect()(CreateTransactionButton)
