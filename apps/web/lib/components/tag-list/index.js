import React, { Component } from 'react'
import styles from './index.css'

export default class TagList extends Component {
	render () {
		const tags = this.props.tags.map((tag) => {
			return <Tag>{tag}</Tag>
		})
		return <ul className={styles['tag-list']}>{tags}</ul>
	}
}

class Tag extends Component {
	render () {
		return <li className={styles.tag}>{this.props.children}</li>
	}
}
