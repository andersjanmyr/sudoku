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
        expect(solution).to.not.be.null

  describe 'solve blank', ->
    it 'works', () ->
      solution = Sudoku.solve(Board.fromString(blank))
      expect(solution).to.not.be.null

  describe 'randomValue', ->
    it 'returns a values between 1 and 9', ->
      value = Sudoku.randomValue()
      expect(value).to.be.at.least(1)
      expect(value).to.be.at.most(9)

  describe 'isSolved', ->
    it 'returns true for a solved board', ->
      solution = Sudoku.solve(Board.fromString(easy))
      expect(Sudoku.isSolved(solution.board)).to.be.true
    it 'returns false for an unsolved board', ->
      expect(Sudoku.isSolved(Board.fromString(easy))).to.be.false

  describe 'generateRandomBoard', ->
    it 'returns a random solved board', ->
      board = Sudoku.generateRandomBoard()
      expect(Sudoku.isSolved(board)).to.be.true

  describe 'hasUniqueSolution', ->
    it 'returns true for a board with a unique solution', ->
      unique = Sudoku.hasUniqueSolution(Board.fromString(easy))
      expect(unique).to.be.true
    it 'returns false for a board with a unique solution', ->
      unique = Sudoku.hasUniqueSolution(Board.fromString(blank))
      expect(unique).to.be.false

  describe 'randomCoordinates', ->
    it 'returns a random list of coordinates', ->
      coords = Sudoku.randomCoordinates()
      expect(coords).to.have.length 81

  describe 'symmetricCoordinates', ->
    it 'returns a symmetric list of coordinates', ->
      coords = Sudoku.symmetricCoordinates()
      expect(coords).to.have.length 25

  describe 'generate', ->
    it 'generates a new board', ->
      board = Sudoku.generate()
      expect(Sudoku.isSolved(board)).to.be.false
      expect(Sudoku.hasUniqueSolution(board)).to.be.true

    it 'generates a new board with minimum difficulty', ->
      board = Sudoku.generate({minDifficulty: 3})
      expect(Sudoku.isSolved(board)).to.be.false
      expect(Sudoku.hasUniqueSolution(board)).to.be.true
      solution = Sudoku.solve(board)

      expect(solution.difficulty).to.be.at.least(3)

    it 'generates a new board with random strategy', ->
      board = Sudoku.generate({strategy: 'random'})
      expect(Sudoku.isSolved(board)).to.be.false
      expect(Sudoku.hasUniqueSolution(board)).to.be.true

