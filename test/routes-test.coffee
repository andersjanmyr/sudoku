request = require 'supertest'
expect = require('chai').expect

express = require 'express'
routes = require '../lib/routes'

app = express()
app.use '/sudoku', routes

describe 'GET /sudoku/generate', ->
  it 'responds with a sudoku board string', (done) ->
    request(app)
      .get('/sudoku/generate')
      .end (err, resp) ->
        expect(err).to.be.null
        expect(resp.status).to.equal(200)
