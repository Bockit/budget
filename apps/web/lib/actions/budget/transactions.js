export function showTransactionModal (transaction) {
	return {
		type: 'MODAL:SHOW',
		modal: 'Transaction',
		data: transaction,
	}
}
