# bat plugin, server-side component
# These handlers are launched with the wiki server. 

startServer = (params) ->
  app = params.app
  argv = params.argv

  logs = {}

  log = (slug) ->
    logs[slug] ||= [{date: Date.now(), text: 'start page'}]

  add = (slug, text) ->
    list = log slug
    date = Date.now()
    list.unshift {date, text}
    list.pop while list.length > 10

  app.post '/plugin/bat/:slug/:thing', (req, res) ->
    slug = req.params.slug
    thing = req.params.thing
    add slug, thing

  app.get '/plugin/bat/:slug/log', (req, res) ->
    res.json log req.params.slug

module.exports = {startServer}
