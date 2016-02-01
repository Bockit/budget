import React, { Component } from 'react'
import { connect } from 'react-redux'
import Nav from '../../containers/nav'
import CreateRecurringButton from '../../containers/create-recurring-button'

class RecurringsPage extends Component {
	render () {
		return (
			<header>
				<Nav>
					<CreateRecurringButton />
				</Nav>
			</header>
		)
	}
}

export default connect()(RecurringsPage)
