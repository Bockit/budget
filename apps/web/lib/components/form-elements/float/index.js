import React, { Component } from 'react'
import styles from './index.css'

export default class Float extends Component {
	render () {
		return (
			<label className={styles['float']}>
				{this.props.children}
				<input type="number" value={this.props.value} step="0.01" />
			</label>
		)
	}
}
