request = require 'supertest'
expect = require('chai').expect
sinon = require 'sinon'

express = require 'express'
routes = require '../lib/routes'
Sudoku = require '../lib/sudoku'

app = express()
app.use '/sudoku', routes

describe 'GET /sudoku/generate', ->
  before ->
    sinon.spy Sudoku, 'generate'

  it 'responds with a sudoku board string', (done) ->
    request(app)
      .get('/sudoku/generate?strategy=random&difficulty=10')
      .end (err, resp) ->
        expect(err).to.be.null
        expect(resp.status).to.equal(200)
        expect(Sudoku.generate.called).to.be.true
        arg = Sudoku.generate.getCall(0).args[0]
        expect(arg).to.deep.equal({
          strategy: 'random',
          difficulty: '10'
        })
        done()

  after ->
    Sudoku.generate.restore()

describe 'GET /sudoku/solve', ->
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

  before ->
    sinon.spy Sudoku, 'solve'

  it 'responds with a sudoku board string', (done) ->
    request(app)
      .get("/sudoku/solve?board=#{encodeURIComponent(easy)}")
      .end (err, resp) ->
        expect(err).to.be.null
        expect(resp.status).to.equal(200)
        expect(Sudoku.solve.called).to.be.true
        expect(resp.body).to.have.property('difficulty')
        expect(resp.body).to.have.property('board')
        done()

  after ->
    Sudoku.solve.restore()
