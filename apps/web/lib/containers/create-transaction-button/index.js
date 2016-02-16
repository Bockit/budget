import React, { Component } from 'react'
import { connect } from 'react-redux'
import { showTransactionModal } from '../../actions/budget/modals'
import Button from '../../components/button'

class CreateTransactionButton extends Component {
	render () {
		return <Button onClick={this.onClick.bind(this)}>New Transaction</Button>
	}

	onClick (ev) {
		ev.keepModal = true
		this.props.dispatch(showTransactionModal())
	}
}

export default connect()(CreateTransactionButton)
