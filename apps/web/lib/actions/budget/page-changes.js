import { loadTransactions } from './transactions'
import range from '../../modules/range'

export function setOverviewPage () {
	return {
		type: 'PAGE:SET',
		pageType: 'Overview',
		pageProps: {},
	}
}

export function setTransactionsPage () {
	return (dispatch) => {
		dispatch({
			type: 'PAGE:SET',
			pageType: 'Transactions',
			pageProps: {},
		})

		const offset = 0
		const limit = 50

		return dispatch(loadTransactions(offset, limit)).then(() => {
			const transactions = range(offset, limit)

			dispatch({
				type: 'PAGE:SET',
				pageType: 'Transactions',
				pageProps: { transactions },
			})
		})
	}
}

export function setRecurringsPage () {
	return {
		type: 'PAGE:SET',
		pageType: 'Recurrings',
		pageProps: {},
	}
}
