import React, { Component } from 'react'
import { connect } from 'react-redux'

class PostPage extends Component {
	render () {
		return (
			<b>Recurring</b>
		)
	}
}

export default connect()(PostPage)
