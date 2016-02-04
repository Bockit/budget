import React, { Component } from 'react'
import { connect } from 'react-redux'
import styles from './index.css'
import Text from '../../form-elements/text'
import Float from '../../form-elements/float'
import Checkbox from '../../form-elements/checkbox'
import Tags from '../../form-elements/checkbox'

class TransactionModal extends Component {
	render () {
		return (
			<div className={styles['transaction-modal']}>
				<Text value={this.props.description}>
						Description
				</Text>

				<Float value={this.props.amount}>
					Amount
				</Float>

				<Tags
					value={this.props.tags}
					tags={this.props.availableTags}
					loading={this.props.tagsLoading}>

					Tags
				</Tags>

				<Checkbox value={this.props.audited}>
					Audited
				</Checkbox>
			</div>
		)
	}
}

function select (state) {
	return {
		availableTags: state.tags.get('tags'),
		tagsLoading: state.tags.get('loading'),
	}
}

export default connect(select)(TransactionModal)
