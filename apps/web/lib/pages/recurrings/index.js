import React, { Component } from 'react'
import { connect } from 'react-redux'

class RecurringsPage extends Component {
	render () {
		return (
			<b>Recurrings</b>
		)
	}
}

export default connect()(RecurringsPage)
