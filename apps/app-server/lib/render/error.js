export default function error (err) {
	return `
		<code>
			<pre>${err.stack}</pre>
		</code>
	`
}
