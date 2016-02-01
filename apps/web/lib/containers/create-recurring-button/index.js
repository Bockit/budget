import React, { Component } from 'react'
import { connect } from 'react-redux'
import { showRecurringModal } from '../../actions/budget/recurrings'
import Button from '../../components/button'

class CreateRecurringButton extends Component {
	render () {
		const onClick = this.props.dispatch.bind(null, showRecurringModal())
		return <Button onClick={onClick}>New Recurring</Button>
	}
}

export default connect()(CreateRecurringButton)
