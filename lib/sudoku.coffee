'use strict';

fs = require 'fs'
Board = require './board'

blank =  """
  .........
  .........
  .........
  .........
  .........
  .........
  .........
  .........
  .........
  """

blankBoard = Board.fromString blank

Sudoku =
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
      matrix = @calcPossibilites board, coords
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

  isSolved: (board) ->
    matrix = @calcPossibilites board, Board.allCoords()
    priorityList = @priorityList(matrix)
    priorityList.length is 0

  randomValue: ->
    parseInt(Math.random() * 9) + 1

  generateRandomBoard: ->
    board = blankBoard.copy()
    board.value(@randomValue(), @randomValue(), '' + @randomValue())
    solution = Sudoku.solve(board)
    solution.board

  hasUniqueSolution: (board) ->
    results = @solveMany(board, 2)
    results.length is 1

  randomCoordinates: ->
    coords = Board.allCoords()
    coords.sort ->
      0.5 - Math.random()
    coords.map (coord) ->
      [coord]

  symmetricCoordinates: ->
    nested = for n in [1..5]
      for m in [1..5]
        oppM = 10-m
        oppN = 10-n
        [[n, m], [n, oppM], [oppN, m], [oppN, oppM]]

    coords = [].concat nested...
    coords =
    coords.sort ->
      0.5 - Math.random()

  eraseValues: (board, coords) ->
    for coord in coords
      board.value(coord[0], coord[1], '.')

  generate: (options={}) ->
    difficulty = -1;
    minDifficulty = options.minDifficulty || 0
    strategy = if options.strategy is 'random'
      @randomCoordinates
    else
      @symmetricCoordinates

    while difficulty < minDifficulty
      coords = strategy()
      board = @generateRandomBoard()
      for cs in coords
        oldBoard = board.copy()
        @eraseValues(board, cs)
        unless @hasUniqueSolution(board)
          board = oldBoard
      solution = Sudoku.solve(oldBoard.copy())
      difficulty = solution.difficulty
    oldBoard

module.exports = Sudoku


