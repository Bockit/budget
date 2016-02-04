export function createLocalTag (tag) {
	return {
		type: 'TAGS:ADD',
		tag,
	}
}
