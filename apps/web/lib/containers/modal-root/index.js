import React, { Component } from 'react'
import Transaction from '../modals/transaction'
import Recurring from '../modals/recurring'
import { connect } from 'react-redux'
import styles from './index.css'

const MODAL_MAP = { Recurring, Transaction }

class ModalRoot extends Component {
	render () {
		// We don't always have a modal
		if (!this.props.modal) return null

		const Modal = MODAL_MAP[this.props.modal]
		return (
			<div className={styles['modal-root']}>
				<Modal {...this.props.data.toObject()} />
			</div>
		)
	}
}

function select (state) {
	return {
		modal: state.modal.get('modal'),
		data: state.modal.get('data'),
	}
}

export default connect(select)(ModalRoot)
