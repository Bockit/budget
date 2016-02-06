export function string (value) {
	return `"${value}"`
}

export function float (value) {
	return `${value}`
}

export function int (value) {
	return `${value}`
}

export function list (value) {
	return value.map(`[${value.join(',')}]`)
}
