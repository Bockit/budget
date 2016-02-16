import React, { Component } from 'react'
import { connect } from 'react-redux'
import styles from './index.css'
import Form from '../../../components/form'
import Text from '../../../components/form-elements/text'
import Amount from '../../../components/form-elements/amount'
import Checkbox from '../../../components/form-elements/checkbox'
import Tags from '../../../components/form-elements/checkbox'

import {
	createLocalTag,
} from '../../../actions/budget/tags'

import {
	addTagToTransaction,
	removeTagFromTransaction,
	updateTransaction,
} from '../../../actions/budget/transactions'

class TransactionModal extends Component {
	render () {
		return (
			<div className={styles['transaction-modal']}>
				<Form>
					<Text
						initialValue={this.props.description}
						onCommit={this.update.bind(this, 'description')}>

						Description
					</Text>

					<Amount
						initialValue={this.props.amount}
						onCommit={this.update.bind(this, 'amount')}>

						Amount
					</Amount>

					<Tags
						initialValue={this.props.tags}
						tags={this.props.availableTags}
						loading={this.props.tagsLoading}
						onAddTag={this.addTag.bind(this)}
						onRemoveTag={this.removeTag.bind(this)}>

						Tags
					</Tags>

					<Checkbox
						initialValue={this.props.audited}
						onCommit={this.update.bind(this, 'audited')}>
						Audited
					</Checkbox>
				</Form>
			</div>
		)
	}

	update (field, value) {
		if (!this.isEditingExistingTransaction()) return
		this.props.dispatch(updateTransaction(this.props.id, field, value))
	}

	addTag (tag) {
		if (this.isEditingExistingTransaction()) {
			this.props.dispatch(createLocalTag(tag))
			this.props.dispatch(addTagToTransaction(tag))
		}
		else {
			this.props.dispatch(createLocalTag(tag))
		}
	}

	removeTag (tag) {
		if (!this.isEditingExistingTransaction()) return
		this.props.dispatch(removeTagFromTransaction(tag))
	}

	isEditingExistingTranscation () {
		return this.props.id != null
	}
}

function select (state) {
	return {
		availableTags: state.tags.get('tags'),
		tagsLoading: state.tags.get('loading'),
	}
}

export default connect(select)(TransactionModal)
