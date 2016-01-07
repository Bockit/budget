import React, { Component } from 'react'
import { connect } from 'react-redux'

class PostsPage extends Component {
	render () {
		return (
			<b>Expenses</b>
		)
	}
}

export default connect()(PostsPage)
