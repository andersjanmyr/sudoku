express = require 'express'
Sudoku = require '../lib/sudoku'
Board = require '../lib/board'

routes = express.Router()

routes.get '/generate', (req, resp) ->
  board = Sudoku.generate({
    strategy: req.param('strategy')
    difficulty: req.param('difficulty')
  })
  resp.send(200, board)

routes.get '/solve', (req, resp) ->
  board = Sudoku.solve(Board.fromString(req.param('board')))
  resp.send(200, board)

module.exports = routes
