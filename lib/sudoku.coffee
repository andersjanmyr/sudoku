'use strict';

fs = require 'fs'

class Board
  constructor: (@coords) ->

  @fromString: (data) ->
    coords = data.split('\n').map (line) ->
      line.split('')
    new Board(coords)

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

  @allCoords: ->
    nested = for r in [1..9]
      for c in [1..9]
        [r, c]
    [].concat nested...


  value: (row, col, v) ->
    return @coords[row-1][col-1] unless v
    @coords[row-1][col-1] = v

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
    return null unless val is '.'
    rs = @values Board.rowCoords(row)
    cs = @values Board.colCoords(col)
    bs = @values Board.boxCoords(row, col)
    takenValues = @unique(rs.concat(cs, bs))
    @availableValues(takenValues)

  toString: ->
    lines = @coords.map (row) ->
      row.join ''
    lines.join '\n'

  copy: ->
    coords = @coords.map (row) ->
      row.slice()
    new Board(coords)



Sudoku = {
  load: (filename, callback) ->
    fs.readFile filename, (err, data) ->
      return callback err if err
      callback null, Board.fromString(data.toString().trim())

  calcPossibilites: (board, coords) ->
    matrix = {}
    coords.forEach (coord) ->
      [r, c] = coord
      v = board.possibleValues(r, c)
      if v
        arr = matrix[v.length] || []
        arr.push([r, c, v])
        matrix[v.length] = arr
    matrix

  priorityList: (matrix) ->
    values = for _, value of matrix
      value
    [].concat values...

  hasSingles: (matrix) ->
    !!matrix[1]

  solve: (board) ->
    @difficulty = 0
    results = @solveMany board, 99
    results[0]

  solveMany: (board, maxAmount) ->
    difficulty = 0
    results = []
    count = 0

    solveRecur = (board, coords, difficulty=0) =>
      if coords.length is 0
        count++
        results.push({ board: board, difficulty: difficulty })
        return
      matrix = Sudoku.calcPossibilites board, coords
      return if matrix[0]
      difficulty++ unless @hasSingles(matrix)
      priorityList = @priorityList(matrix)
      first = priorityList.shift()
      [r, c, values] = first
      for v in values
        boardCopy = board.copy()
        boardCopy.value(r, c, v)
        solveRecur boardCopy, priorityList, difficulty
        return if count is maxAmount

    solveRecur(board, Sudoku.Board.allCoords())
    results
}

module.exports = Sudoku
Sudoku.Board = Board


