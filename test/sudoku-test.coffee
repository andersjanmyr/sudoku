expect = require('chai').expect;

Sudoku = require '../lib/sudoku'
Board = require '../lib/board'

describe 'Sudoku', ->
  easy = null
  blank = null
  before ->
    blank = """
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
    easy = """
      51.....83
      8..416..5
      .........
      .985.461.
      ...9.1...
      .642.357.
      .........
      6..157..4
      78.....96
      """

  describe 'load', ->
    it 'loads the named board from file', (done) ->
      Sudoku.load "#{__dirname}/fixtures/easy.sudoku", (err, board) ->
        expect(board.toString()).to.equal easy
        done()

  describe 'Sudoku methods', ->
    board = null
    before ->
      board = Board.fromString(easy)

    it 'calcPossibilites creates a possibilities matrix', ->
      matrix = Sudoku.calcPossibilites(board, Board.allCoords())
      expect(matrix[1]).to.have.length 8

    it 'priorityList returns an array of coordinates', ->
      matrix = Sudoku.calcPossibilites(board, Board.allCoords())
      priorityList = Sudoku.priorityList(matrix)
      expect(priorityList).to.have.length 49

    it 'solve solves the sudoku or fails', ->
      solution = Sudoku.solve(board)
      expect(solution).to.not.be.null

  describe 'solve easy', ->
    board = null
    before (done) ->
      Sudoku.load "#{__dirname}/fixtures/easy.sudoku", (err, b) ->
        board = b
        done()

    it 'works', () ->
        solution = Sudoku.solve(board)
        expect(solution).to.not.be.null

  describe 'solve medium', ->
    board = null
    before (done) ->
      Sudoku.load "#{__dirname}/fixtures/medium.sudoku", (err, b) ->
        board = b
        done()

    it 'works', () ->
        solution = Sudoku.solve(board)
        expect(solution).to.not.be.null


  describe 'solve hard', ->
    board = null
    before (done) ->
      Sudoku.load "#{__dirname}/fixtures/hard.sudoku", (err, b) ->
        board = b
        done()

    it 'works', () ->
        solution = Sudoku.solve(board)
        expect(solution).to.not.be.null


  describe 'solve samurai', ->
    board = null
    before (done) ->
      Sudoku.load "#{__dirname}/fixtures/samurai.sudoku", (err, b) ->
        board = b
        done()

    it 'works', () ->
        solution = Sudoku.solve(board)
        expect(solution).to.not.be.null

  describe 'solve impossible', ->
    board = null
    before (done) ->
      Sudoku.load "#{__dirname}/fixtures/impossible.sudoku", (err, b) ->
        board = b
        done()

    it 'works', () ->
        solution = Sudoku.solve(board)
        console.log solution.difficulty
        expect(solution).to.not.be.null

  describe 'solve blank', ->
    it 'works', () ->
      solution = Sudoku.solve(Board.fromString(blank))
      expect(solution).to.not.be.null

