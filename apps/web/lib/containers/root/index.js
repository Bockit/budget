import React, { Component } from 'react'
import Overview from '../../pages/overview'
import Recurrings from '../../pages/recurrings'
import Transactions from '../../pages/transactions'
import ModalRoot from '../modal-root'
import { connect } from 'react-redux'
import { hideModals } from '../../actions/budget/modals'

const PAGE_MAP = { Overview, Recurrings, Transactions }

class Root extends Component {
	render () {
		const Page = PAGE_MAP[this.props.pageType]

		return (
			<main onClick={this.onClick.bind(this)}>
				<Page {...this.props.pageProps.toObject()} />
				<ModalRoot />
			</main>
		)
	}

	onClick (ev) {
		if (!ev.keepModal) this.props.dispatch(hideModals())
		delete ev.keepModal
	}
}

export default connect((state) => state.app.toObject())(Root)
