import { combineReducers } from 'redux'
import app from './app'
import modal from './modal'
import tags from './tags'
import transactions from './transactions'

export default combineReducers({ app, modal, tags, transactions })
