'use strict';

fs = require 'fs'
Board = require './board'


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

    solveRecur(board, Board.allCoords())
    results
}

module.exports = Sudoku


