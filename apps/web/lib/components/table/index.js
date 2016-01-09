import React, { Component } from 'react'
import styles from './index.css'

export default class Table extends Component {
	render () {
		const headings = this.props.columns.map((column) => {
			const cellStyle = styles[`table-heading-${column}`] || ''
			const className = `${styles['table-heading']} ${cellStyle}`.trim()
			return <th className={className}>{column}</th>
		})

		const tableStyle = styles[`table-${this.props.type}`] || ''
		const className = `${styles.table} ${tableStyle}`.trim()

		return (
			<table className={className}>
				<thead><tr>{headings}</tr></thead>
				<tbody>{this.props.children}</tbody>
			</table>
		)
	}
}
