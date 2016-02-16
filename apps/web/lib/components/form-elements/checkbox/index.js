import React, { Component } from 'react'
import styles from './index.css'

export default class Checkbox extends Component {
	/* eslint react/no-set-state: 0 */
	constructor (props) {
		super(props)
		this.state = {
			value: props.initialValue,
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
					onChange={this.onChange.bind(this)} />
			</label>
		)
	}

	onChange () {
		this.setState({ value: this.refs.input.checked })
		if (this.props.onCommit) this.props.onCommit(this.state.value)
	}
}
