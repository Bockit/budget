import React, { Component } from 'react'
import { connect } from 'react-redux'
import styles from './index.css'

class RecurringModal extends Component {
	render () {
		return (
			<span className={styles['recurring-modal']}>
				Recurring Modal
			</span>
		)
	}
}

export default connect()(RecurringModal)
