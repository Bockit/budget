export function showRecurringModal (recurring) {
	return {
		type: 'MODAL:SHOW',
		modal: 'Recurring',
		data: recurring,
	}
}
