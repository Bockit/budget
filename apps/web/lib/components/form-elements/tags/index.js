import React, { Component } from 'react'
import styles from './index.css'

const ENTER = 13

export default class Tags extends Component {
	render () {
		if (loading) return this.renderLoading()

		return (
			<div className={styles['tag-list']}>
				<ul>
					{this.renderTags()}
				</ul>
				<AddTagButton onAddTag={this.props.addTag}/>
			</div>
		)
	}

	renderLoading () {
		return <div className={styles['tags-loading']}></div>
	}

	renderTags () {
		return this.props.tags.map((tag, index) => {
			let className = styles['tag']
			if (this.props.value.indexOf(tag) >= 0) className += ' active'

			return (
				<li
					className={className}
					onClick={this.onClick.bind(this, index)}>
					{tag}>
				</li>
			)
		})
	}

	onClick (index) {
		const tag = this.props.tags[index]
		const hasTag = this.props.value.indexOf(tag) > 0
		if (hasTag) {
			this.props.deactivateTag(tag)
		}
		else {
			this.props.activateTag(tag)
		}
	}
}

export class AddTagButton extends Component {
	/* eslint react/no-set-state: 0 */
	getInitialState () {
		return {
			value: '',
			editing: false,
		}
	}

	render () {
		/* eslint no-else-return: 0 */
		if (this.editing) {
			return this.renderEditing()
		}
		else {
			return this.renderButton()
		}
	}

	renderButton () {
		return (
			<button
				className={styles['add-tag-button']}
				type="button"
				onClick={this.onClick.bind(this)}>
				New Tag
			</button>
		)
	}

	renderEditing () {
		return (
			<input
				ref="input"
				className={styles['add-tag-input']}
				type="text"
				onKeyDown={this.onKeyDown.bind(this)}
				onBlur={this.onBlur.bind(this)}
				value={this.state.value} />
		)
	}

	onClick () {
		this.setState({ editing: true, value: '' })
	}

	onKeyDown (ev) {
		if (ev.keyCode === ENTER) {
			this.createTag()
		}
		else {
			this.setState({ value: this.refs.input.value.trim() })
		}
	}

	onBlur () {
		this.createTag()
	}

	createTag () {
		this.setState({ editing: false })
		this.onAddTag(this.state.value)
	}
}
