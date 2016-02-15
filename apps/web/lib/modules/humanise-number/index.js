/**
* format number by adding thousands separaters and significant digits while
* rounding
*
* @param {Number} number The number to format
* @param {Number} decimals The number of decimals to keep
* @param {String} decPoint The character to use as the decimal point
* @param {String} thousandsSep The character to use as a thousand separator
* @returns {String} The formatted string
*/
export default humanise

function humanise (number, decimals = 2, decPoint = '.', thousandsSep = ',') {
	decimals = isNaN(decimals) ? 2 : Math.abs(decimals)
	decPoint = (decPoint === undefined) ? '.' : decPoint
	thousandsSep = (thousandsSep === undefined) ? ',' : thousandsSep

	var sign = number < 0 ? '-' : ''
	number = Math.abs(+number || 0)

	const intPart = `${+(number.toFixed(decimals))}`
	const j = intPart.length > 3 ? intPart.length % 3 : 0

	const firstGroup = j ? intPart.substr(0, j) + thousandsSep : ''
	const rest = intPart.substr(j)
	const groupsOfThree = rest.replace(/(\d{3})(?=\d)/g, `$1${thousandsSep}`)

	const decimalDigits = Math.abs(number - intPart).toFixed(decimals).slice(2)

	const trailing = decimals ? `${decPoint}${decimalDigits}` : ''

	return `${sign}${firstGroup}${groupsOfThree}${trailing}`
}
