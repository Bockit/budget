import React, { Component } from 'react'
import { connect } from 'react-redux'
import Nav from '../../components/nav'

class OverviewPage extends Component {
	render () {
		return (
			<header>
				<Nav active="overview" />
				<b>Overview</b>
			</header>
		)
	}
}

export default connect()(OverviewPage)
