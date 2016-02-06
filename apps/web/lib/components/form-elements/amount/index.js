import React, { Component } from 'react'
import styles from './index.css'

export default class Amount extends Component {
	/* eslint react/no-set-state: 0 */
	getInitialState () {
		return {
			value: this.props.initialValue,
		}
	}

	render () {
		return (
			<label className={styles['float']}>
				{this.props.children}
				<input
					ref="input"
					type="number"
					value={this.state.value}
					step="0.01"
					onChange={this.onChange.bind(this)}
					onBlur={this.onBlur.bind(this)} />
			</label>
		)
	}

	onChange () {
		this.setState({ value: this.refs.input.value })
		if (this.props.onChange) this.props.onChange()
	}

	onBlur () {
		if (this.props.onCommit) this.props.onCommit(this.state.value)
	}
}
