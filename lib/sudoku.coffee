'use strict';

fs = require 'fs'

class Board
  constructor: (@data) ->
    @coords = @data.split('\n').map (line) ->
      line.split('')

  value: (row, col) ->
    @coords[row-1][col-1]

  values: (coords) ->
    @value(r, c) for [r, c] in coords

  unique: (values) ->
    index = {}
    for v in values when not (v of index or v is '.')
      index[v] = true
      v

  availableValues: (takenValues) ->
    "#{v}" for v in [1..9] when "#{v}" not in takenValues

  possibleValues: (row, col) ->
    val = @value row, col
    return [val] unless val is '.'
    rs = @values Board.rowCoords(row)
    cs = @values Board.colCoords(col)
    bs = @values Board.boxCoords(row, col)
    takenValues = @unique(rs.concat(cs, bs))
    console.log takenValues
    @availableValues(takenValues)



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

  toString: ->
    @data



Sudoku = {
  load: (filename, callback) ->
    fs.readFile filename, (err, data) ->
      return callback err if err
      callback null, new Board(data.toString().trim())

}

module.exports = Sudoku
Sudoku.Board = Board


