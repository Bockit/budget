import request from '../request'
import { string, list, boolean } from './serialise-argument'

export function createRecurring (recurring) {
	const { timestamp, amount, description } = recurring
	const tags = list(recurring.tags.map(string))

	return request(`
		mutation CreateRecurring {
			createRecurring(
				timestamp:${string(timestamp)}
				amount:${float(amount)}
				description:${string(description)}
				tags:${tags}
			) {}
		}
	`)
}

export function updateRecurring (id, field, value) {
	const body = `
		mutation UpdateRecurring {
			updateRecurring(
				${field}: ${JSON.stringify(value)}
			) {}
		}
	`

	return request(body)
}

export function deleteRecurring (id) {
	return request(`
		mutation DeleteRecurring {
			deleteRecurring(id:${string(id)}) {}
		}
	`)
}

export function addTagsToRecurring (id, tags) {
	tags = list(tags.map(string))

	return request(`
		mutation AddTagsToRecurring {
			addTagsToRecurring(id:${string(id)}, tags:${tags}) {}
		}
	`)
}

export function removeTagsFromRecurring (id, tags) {
	tags = list(tags.map(string))

	return request(`
		mutation RemoveTagsFromRecurring {
			removeTagsFromRecurring(id:${string(id)}, tags:${tags}) {}
		}
	`)
}

export function createTransaction (transaction) {
	const { frequency, amount, description, audited } = transaction
	const tags = list(transaction.tags.map(string))

	return request(`
		mutation CreateTransaction {
			createTransaction(
				frequency:${string(frequency)}
				amount:${float(amount)}
				description:${string(description)}
				audited:${boolean(audited)}
				tags:${tags}
			) {}
		}
	`)
}

export function updateTransaction (id, field, value) {
	const body = `
		mutation UpdateTransaction {
			updateTransaction(
				${field}: ${JSON.stringify(value)}
			) {}
		}
	`

	return request(body)
}

export function deleteTransaction (id) {
	return request(`
		mutation DeleteTransaction {
			deleteTransaction(id:${string(id)}) {}
		}
	`)
}

export function addTagsToTransaction (id, tags) {
	tags = list(tags.map(string))

	return request(`
		mutation AddTagsToTransaction {
			addTagsToTransaction(id:${string(id)}, tags:${tags}) {}
		}
	`)
}

export function removeTagsFromTransaction (id, tags) {
	tags = list(tags.map(string))

	return request(`
		mutation RemoveTagsFromTransaction {
			removeTagsFromTransaction(id:${string(id)}, tags:${tags}) {}
		}
	`)
}
