import React, { Component } from 'react'
import styles from './index.css'

export default class Checkbox extends Component {
	/* eslint react/no-set-state: 0 */
	getInitialState () {
		return {
			value: this.props.initialValue,
		}
	}

	render () {
		return (
			<label className={styles['checkbox']}>
				{this.props.children}
				<input
					ref="input"
					type="checkbox"
					checked={this.state.value}
					onChange={this.props.onChange.bind(this)} />
			</label>
		)
	}

	onChange () {
		this.setState({ value: this.refs.input.checked })
		if (this.props.onCommit) this.props.onCommit(this.state.value)
	}
}