import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import * as pageChangeActions from '../../actions/budget/page-changes'
import styles from './index.css'

class Nav extends Component {
	render () {
		const {
			setOverviewPage,
			setTransactionsPage,
			setRecurringsPage,
		} = bindActionCreators(pageChangeActions, this.props.dispatch)

		return (
			<nav className={styles['nav-bar']}>
				<NavLink
					active={this.isActive('Overview')}
					href="/overview"
					onClick={setOverviewPage}>
						Overview
				</NavLink>
				<NavLink
					active={this.isActive('Transactions')}
					href="/transactions"
					onClick={setTransactionsPage}>
						Transactions
				</NavLink>
				<NavLink
					active={this.isActive('Recurrings')}
					href="/recurrings"
					onClick={setRecurringsPage}>
						Recurring
				</NavLink>
				<div className={styles['nav-buttons']}>
					{this.props.children}
				</div>
			</nav>
		)
	}

	isActive (name) {
		return this.props.active === name
	}
}

function select (state) {
	return { active: state.app.get('pageType') }
}

export default connect(select)(Nav)

class NavLink extends Component {
	render () {
		return (
			<a
				className={this.getClassName()}
				href={this.props.href}
				onClick={this.onClick.bind(this)}>
					{this.props.children}
			</a>
		)
	}

	getClassName () {
		return `${styles['nav-link']} ${this.props.active ? 'active' : ''}`
	}

	onClick (ev) {
		ev.preventDefault()
		this.props.onClick()
	}
}
