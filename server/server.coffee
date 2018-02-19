# bat plugin, server-side component
# These handlers are launched with the wiki server. 

startServer = (params) ->
  app = params.app
  argv = params.argv

  log = [{date: Date.now(), text: 'start server'}]

  app.post '/plugin/bat/:thing', (req, res) ->
    thing = req.params.thing
    log.unshift {date: Date.now(), text: thing}
    log.pop while log.length > 10
    res.json log

  app.get '/plugin/bat/log', (req, res) ->
    res.json log

module.exports = {startServer}
