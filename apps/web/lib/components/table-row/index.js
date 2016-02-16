import React, { Component } from 'react'
import styles from './index.css'
import capitalise from '../../modules/capitalise'
import humanise from '../../modules/humanise-number'

export default class TableRow extends Component {
	render () {
		const cells = this.props.columns.map((column) => {
			let value = this.props.entry.get(column)

			const method = `format${capitalise(column)}`
			if (this[method]) value = this[method](value)

			return (
				<TableCell
					key={column}
					column={column}>
					{value}
				</TableCell>
			)
		})

		return <tr>{cells}</tr>
	}

	formatTags (tags) {
		return tags.join(', ')
	}

	formatAmount (amount) {
		return humanise(amount)
	}
}

class TableCell extends Component {
	render () {
		const cellStyle = styles[`table-row-cell-${this.props.column}`] || ''
		const className = `${styles['table-row-cell']} ${cellStyle}`.trim()
		return <td className={className}>{this.props.children}</td>
	}
}
