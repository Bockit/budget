import request from '../request'

export function createRecurring (recurring) {

}

export function updateRecurring (recurring) {

}

export function deleteRecurring (id) {

}

export function addTagsToRecurring (id, tags) {

}

export function removeTagsFromRecurring (id, tags) {

}

export function createTransaction (transaction) {
	const { frequency, amount, description, audited } = transaction
	const tags = JSON.stringify(transaction.tags || [])

	body = `
		mutation UpdateTransaction {
			updateTransaction(
				frequency:"${frequency}"
				amount:${JSON.stringify(amount)}
				description:"${description}"
				audited:${JSON.stringify(audited)}
				tags:${tags}
			){}
		}
	`
}

export function updateTransaction (transaction) {
	const { id, frequency, amount, description, audited } = transaction

	body = `
		mutation UpdateTransaction {
			updateTransaction(
				id:"${id}"
				frequency:"${frequency}"
				amount:${JSON.stringify(amount)}
				description:"${description}"
				audited:${JSON.stringify(audited)}
			){}
		}
	`
}

export function deleteTransaction (id) {
	body = `
		mutation DeleteTransaction {
			deleteTransaction(id:"${id}") {}
		}
	`
	return request(body)
}

export function addTagsToTransaction (id, tags) {
	tags = JSON.stringify(tags)

	body = `
		mutation AddTagsToTransaction {
			addTagsToTransaction(id:"${id}", tags:${tags}) {}
		}
	`
	return request(body)
}

export function removeTagsFromTransaction (id, tags) {
	tags = JSON.stringify(tags)

	body = `
		mutation RemoveTagsFromTransaction {
			removeTagsFromTransaction(id:"${id}", tags:${JSON.stringify(tags)}) {}
		}
	`
	return request(body)
}
