express = require 'express'
Sudoku = require '../lib/sudoku'

routes = express.Router()

routes.get '/generate', (req, resp) ->
  console.log 'params', req.params
  console.log 'query', req.query
  resp.send(500)

routes.get '/solve', (req, resp) ->
  console.log 'params', req.params
  console.log 'query', req.query
  resp.send(500)

module.exports = routes
