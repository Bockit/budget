import React, { Component } from 'react'
import styles from './index.css'

export default class TableRow extends Component {
	render () {
		const cells = this.props.columns.map((column) => {
			let value = this.props.entry.get(column)

			if (column === 'tags') {
				value = value.map((tag) => tag.get('tag')).join(', ')
			}

			return (
				<TableCell
					key={column}
					type={this.props.type}>
					{value}
				</TableCell>
			)
		})

		// { type, value }) => {
		// 	list.push(<TableCell type={type}>{value}</TableCell>)
		// }, [])

		return <tr>{cells}</tr>
	}
}

class TableCell extends Component {
	render () {
		const cellStyle = styles[`table-row-cell-${this.props.type}`] || ''
		const className = `${styles['table-row-cell']} ${cellStyle}`.trim()
		return <td className={className}>{this.props.children}</td>
	}
}
