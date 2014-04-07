express = require 'express'
routes = require './routes'

app = express()

app.get '/status', (req, res) ->
  res.send 'Server is running'

app.use '/sudoku', routes

module.exports = app

