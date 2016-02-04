import React, { Component } from 'react'
import styles from './index.css'

export default class Checkbox extends Component {
	render () {
		return (
			<label className={styles['checkbox']}>
				{this.props.children}
				<input type="checkbox" value={this.props.value} />
			</label>
		)
	}
}
