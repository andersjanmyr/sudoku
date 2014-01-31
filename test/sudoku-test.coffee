expect = require('chai').expect;

Sudoku = require '../lib/sudoku'

describe 'Sudoku', ->
  easy = null
  before ->
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
      board = Sudoku.Board.fromString(easy)

    it 'calcPossibilites creates a possibilities matrix', ->
      matrix = Sudoku.calcPossibilites(board, Sudoku.Board.allCoords())
      expect(matrix[1]).to.have.length 8

    it 'placeSingles places single values on the board', ->
      matrix = Sudoku.calcPossibilites(board, Sudoku.Board.allCoords())
      before = board.toString()
      Sudoku.placeSingles(board, matrix[1])
      expect(board.toString()).to.not.equal(before)

    it 'nonSingles returns an array of coordinates', ->
      matrix = Sudoku.calcPossibilites(board, Sudoku.Board.allCoords())
      nonSingles = Sudoku.nonSingles(matrix)
      expect(nonSingles).to.have.length 32

    it 'solve solves the sudoku or fails', ->
      solution = Sudoku.solve(board)
      expect(solution).to.not.be.null
      console.log solution.toString()

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


  describe.skip 'solve hard', ->
    board = null
    before (done) ->
      Sudoku.load "#{__dirname}/fixtures/hard.sudoku", (err, b) ->
        board = b
        done()

    it 'works', () ->
        solution = Sudoku.solve(board)
        expect(solution).to.not.be.null


  describe.skip 'solve samurai', ->
    board = null
    before (done) ->
      Sudoku.load "#{__dirname}/fixtures/samurai.sudoku", (err, b) ->
        board = b
        done()

    it 'works', () ->
        solution = Sudoku.solve(board)
        expect(solution).to.not.be.null




  describe 'Board', ->
    describe 'rowCoords', ->
      it 'returns proper coords for row 1', ->
        coords = Sudoku.Board.rowCoords 1
        expect(coords).to.deep.equal([[1, 1], [1, 2], [1, 3], [1, 4],
          [1, 5], [1, 6], [1, 7], [1, 8], [1, 9]])

    describe 'colCoords', ->
      it 'returns proper coords for col 1', ->
        coords = Sudoku.Board.colCoords 1
        expect(coords).to.deep.equal([[1, 1], [2, 1], [3, 1], [4, 1],
          [5, 1], [6, 1], [7, 1], [8, 1], [9, 1]])

    describe 'boxCoords', ->
      it 'returns proper coords for row 1, col 1', ->
        coords = Sudoku.Board.boxCoords 1, 1
        expect(coords).to.deep.equal([[1, 1], [2, 1], [3, 1], [1, 2],
          [2, 2], [3, 2], [1, 3], [2, 3], [3, 3]])
      it 'returns proper coords for row 4, col 5', ->
        coords = Sudoku.Board.boxCoords 4, 5
        expect(coords).to.deep.equal([[4, 4], [5, 4], [6, 4], [4, 5],
          [5, 5], [6, 5], [4, 6], [5, 6], [6, 6]])

  describe 'Board instance', ->
    board = null
    before ->
      board = Sudoku.Board.fromString(easy)

    describe 'coords', ->
      it 'returns an array with arrays', ->
        expect(board.coords).to.have.length 9
        expect(board.coords[8]).to.have.length 9

    describe 'possibleValues', ->
      it 'returns null for value', ->
        expect(board.possibleValues(1, 1)).to.be.null

      it 'returns free values for dot', ->
        vals = board.possibleValues(3, 1)
        expect(vals).to.deep.equal ['2', '3', '4', '9']

    describe 'copy', ->
      it 'returns a copy', ->
        copy = board.copy()
        expect(copy.coords).to.have.length 9
        expect(copy.coords[8]).to.have.length 9


