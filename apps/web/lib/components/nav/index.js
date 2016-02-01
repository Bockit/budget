import React, { Component } from 'react'
import { connect } from 'react-redux'
import {
	setOverviewPage,
	setTransactionsPage,
	setRecurringsPage,
} from '../../actions/budget/page-changes'

import styles from './index.css'

class Nav extends Component {
	render () {
		return (
			<nav className={styles['nav-bar']}>
				<NavLink
					active={this.isActive('overview')}
					href="/overview"
					onClick={this.makeClickHandler(setOverviewPage)}>
						Overview
				</NavLink>
				<NavLink
					active={this.isActive('transactions')}
					href="/transactions"
					onClick={this.makeClickHandler(setTransactionsPage)}>
						Transactions
				</NavLink>
				<NavLink
					active={this.isActive('recurrings')}
					href="/recurrings"
					onClick={this.makeClickHandler(setRecurringsPage)}>
						Recurring
				</NavLink>
			</nav>
		)
	}

	isActive (name) {
		return this.props.active === name
	}

	makeClickHandler (actionCreator) {
		return (ev) => {
			ev.preventDefault()
			this.props.dispatch(actionCreator())
		}
	}
}

export default connect()(Nav)

class NavLink extends Component {
	render () {
		return (
			<a
				className={this.getClassName()}
				href={this.props.href}
				onClick={this.props.onClick}>
					{this.props.children}
			</a>
		)
	}

	getClassName () {
		return `${styles['nav-link']} ${this.props.active ? 'active' : ''}`
	}
}
