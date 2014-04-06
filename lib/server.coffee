express = require 'express'
routes = require './routes'

app = express()

app.get '/status', (req, res) ->
  res.send 'Server is running'

app.use '/', routes

module.exports = app

