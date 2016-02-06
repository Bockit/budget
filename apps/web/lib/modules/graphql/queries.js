import request from './request'
import { int } from './serialise-argument'

export function allTags () {
	return request(`
		query AllTags {
			tags(limit: 100000) { tag }
		}
	`)
}

export function getTransactions (offset = 0, limit = 50) {
	return request(`
		query GetTransactions{
			transactions(
				offset:${int(offset)}
				limit:${int(limit)}
			) {
				id
				timestamp
				amount
				description
				audited
				tags {
					tag
				}
			}
		}
	`)
}

export function getRecurrings (offset = 0, limit = 50) {
	return request(`
		query GetRecurrings{
			recurrings(
				offset:${int(offset)}
				limit:${int(limit)}
			) {
				id
				frequency
				amount
				description
				tags {
					tag
				}
			}
		}
	`)
}
