import React, { Component } from 'react'
import styles from './index.css'

export default class Text extends Component {
	render () {
		return (
			<label className={styles['text']}>
				{this.props.children}
				<input type="text" value={this.props.value} />
			</label>
		)
	}
}
