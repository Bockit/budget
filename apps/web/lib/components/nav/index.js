import React, { Component } from 'react'
import styles from './index.css'

export default class Nav extends Component {
	render () {
		return (
			<nav>
				<NavLink
					active={this.isActive('overview')}
					href="/overview">
						Overview
				</NavLink>
				<NavLink
					active={this.isActive('transactions')}
					href="/transactions">
						Transactions
				</NavLink>
				<NavLink
					active={this.isActive('recurring')}
					href="/recurring">
						Recurring
				</NavLink>
			</nav>
		)
	}

	isActive (name) {
		return this.props.active === name
	}
}

class NavLink extends Component {
	render () {
		return (
			<a
				className={this.getClassName()}
				href={this.props.href}>
					{this.props.children}
			</a>
		)
	}

	getClassName () {
		return `${styles['nav-link']} ${this.props.active ? 'active' : ''}`
	}
}
