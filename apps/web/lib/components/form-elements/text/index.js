import React, { Component } from 'react'
import styles from './index.css'

export default class Text extends Component {
	/* eslint react/no-set-state: 0 */
	constructor (props) {
		super(props)
		this.state = {
			value: props.initialValue,
		}
	}

	render () {
		return (
			<label className={styles['text']}>
				{this.props.children}
				<input
					ref="input"
					type="text"
					value={this.state.value}
					onChange={this.onChange.bind(this)}
					onBlur={this.onBlur.bind(this)} />
			</label>
		)
	}

	onChange () {
		this.setState({ value: this.props.initialValue })
		if (this.props.onChange) this.props.onChange(this.state.value)
	}

	onBlur () {
		if (this.props.onCommit) this.props.onCommit(this.state.value)
	}
}
