import React, { Component } from 'react'
import styles from './index.css'

export default class Table extends Component {
	render () {
		const cells = cells.map(({ type, value }) => {
			return <TableCell type={type}>{value}</TableCell>
		})

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
