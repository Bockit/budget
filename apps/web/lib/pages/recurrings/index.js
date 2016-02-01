import React, { Component } from 'react'
import { connect } from 'react-redux'
import Nav from '../../components/nav'

class RecurringsPage extends Component {
	render () {
		return (
			<header>
				<Nav active="recurrings" />
				<b>Recurring</b>
			</header>
		)
	}
}

export default connect()(RecurringsPage)
