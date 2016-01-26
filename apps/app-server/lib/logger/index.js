import winston from 'winston'
import config from 'config'
winston.level = config.get('logs.level')
export default winston
