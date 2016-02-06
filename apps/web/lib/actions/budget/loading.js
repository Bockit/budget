export function start (namespace, operation, props) {
	return {
		type: `${namespace}:LOADING:START`,
		operation,
		...props,
	}
}

export function stop (namespace, operation, props) {
	return {
		type: `${namespace}:LOADING:STOP`,
		operation,
		...props,
	}
}

export function error (namespace, operation, err, props) {
	return {
		type: `${namespace}:LOADING:ERROR`,
		operation,
		error: err,
		...props,
	}
}
