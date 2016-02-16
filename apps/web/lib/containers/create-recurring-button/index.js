import React, { Component } from 'react'
import { connect } from 'react-redux'
import { showRecurringModal } from '../../actions/budget/modals'
import Button from '../../components/button'

class CreateRecurringButton extends Component {
	render () {
		return <Button onClick={this.onClick.bind(this)}>New Recurring</Button>
	}

	onClick (ev) {
		ev.keepModal = true
		this.props.dispatch(showRecurringModal())
	}
}

export default connect()(CreateRecurringButton)
