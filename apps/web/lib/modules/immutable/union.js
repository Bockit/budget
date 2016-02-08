import { List } from 'immutable'

// Courtesy of http://stackoverflow.com/posts/30128393
export default function union (list1, list2) {
	const uniques = {}

	list1.forEach((record) => {
		uniques[record.get('id')] = record
	})

	list2.forEach((record) => {
		uniques[record.get('id')] = record
	})

	return Object.keys(uniques).reduce((list, id) => {
		return list.push(uniques[id])
	}, List())
}
