# Modules
connect = require 'connect'
path = require 'path'

# Middleware
coffee = require './connect-coffee'
jade = require './connect-jade'
reload = require './connect-reload'
stylus = require './connect-stylus'

# Export helpfulness
module.exports = ({address, dir, format, port}) ->
  app = connect()
  server = app.listen port, address

  app.use(connect.favicon())
    .use(connect.logger format)
    .use(reload {dir, server})
    .use(coffee dir)
    .use(jade dir)
    .use(stylus dir)
    .use(connect.static dir)
    .use(connect.directory dir)

  console.log 'Serving %s at http://%s:%s/', dir, address, port
