import React, { Component } from 'react'
import { connect } from 'react-redux'

class OverviewPage extends Component {
	render () {
		return (
			<b>Overview</b>
		)
	}
}

export default connect()(OverviewPage)
