import React, { Component } from 'react'
import styles from './index.css'

export default class Form extends Component {
	render () {
		const children = this.props.children.map((child, index) => {
			return <div key={index} className={styles['form-row']}>{child}</div>
		})

		return <div className={styles['form']}>{children}</div>
	}
}
