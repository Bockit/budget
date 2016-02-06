import React, { Component } from 'react'
import styles from './index.css'

export default class Button extends Component {
	render () {
		return (
			<button
				type="button"
				className={styles['button']}
				onClick={this.props.onClick}>
				{this.props.children}
			</button>
		)
	}
}
