expect = require('chai').expect;

Sudoku = require '../lib/sudoku'

describe 'Sudoku', ->
  describe 'load', ->
    it 'loads the named board from file', (done) ->
      Sudoku.load "#{__dirname}/fixtures/easy.sudoku", (err, board) ->
        expect(board.toString()).to.equal("""
          51.....83
          8..416..5
          .........
          .985.461.
          ...9.1...
          .........
          6..157..4
          78.....96
          """)
        done()

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


