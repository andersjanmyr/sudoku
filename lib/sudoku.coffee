'use strict';

fs = require 'fs'

class Board
  constructor: (@data) ->

  toString: ->
    @data

  @rowCoords: (row) ->
    [row, col] for col in [1..9]

  @colCoords: (col) ->
    [row, col] for row in [1..9]

  @boxCoords: (row, col) ->
    [row, col] for row in [1..9]


Sudoku = {
  load: (filename, callback) ->
    fs.readFile filename, (err, data) ->
      return callback err if err
      callback null, new Board(data.toString().trim())

}

module.exports = Sudoku
Sudoku.Board = Board


