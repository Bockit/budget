import React, { Component } from 'react'
import { connect } from 'react-redux'
import Nav from '../../containers/nav'
import CreateTransactionButton from '../../containers/create-transaction-button'
import Table from '../../components/table'
import TableRow from '../../components/table-row'

const HEADINGS = [ 'Description', 'Tags', 'Date', 'Amount' ]
const COLUMNS = [ 'description', 'tags', 'timestamp', 'amount' ]

class TransactionsPage extends Component {
	render () {
		return (
			<div>
				<header>
					<Nav>
						<CreateTransactionButton />
					</Nav>
				</header>
				<Table type="transactions" columns={HEADINGS}>
					{this.renderRows()}
				</Table>
			</div>
		)
	}

	renderRows () {
		return this.props.transactions.map((transaction) => {
			return (
				<TableRow
					key={transaction.get('id')}
					columns={COLUMNS}
					entry={transaction} />
			)
		})
	}
}

function select (state) {
	return { transactions: state.transactions }
}

export default connect(select)(TransactionsPage)
