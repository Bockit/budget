import React, { Component } from 'react'
import styles from './index.css'

export default class NewButton extends Component {
	render () {
		return (
			<button className={styles['new-button']} onClick={this.props.onclick}>
				New {this.props.type}
			</button>
		)
	}
}
