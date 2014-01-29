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

  @base: (val) ->
    return 0 if val <=3
    return 3 if val <=6
    return 6

  @boxCoords: (row, col) ->
    rowBase = @base row
    colBase = @base col

    [rowBase+r, colBase+c] for [r, c] in [[1, 1], [2, 1], [3, 1], [1, 2],
          [2, 2], [3, 2], [1, 3], [2, 3], [3, 3]]


Sudoku = {
  load: (filename, callback) ->
    fs.readFile filename, (err, data) ->
      return callback err if err
      callback null, new Board(data.toString().trim())

}

module.exports = Sudoku
Sudoku.Board = Board


