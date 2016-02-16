export function showTransactionModal (transaction) {
	return {
		type: 'MODAL:SHOW',
		modal: 'Transaction',
		data: transaction,
	}
}

export function showRecurringModal (recurring) {
	return {
		type: 'MODAL:SHOW',
		modal: 'Recurring',
		data: recurring,
	}
}

export function hideModals () {
	return {
		type: 'MODAL:HIDE',
	}
}
