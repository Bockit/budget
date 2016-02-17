export default function range (lower, upper) {
	const result = Array(upper - lower)
	for (let i = lower; i < upper; i++) {
		result[i] = i
	}
}
