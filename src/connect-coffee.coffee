# Modules
coffee = require 'coffee-script'
fs = require 'fs'
path = require 'path'

# Options
extension = /\.js$/

# Export middleware
module.exports = (dir) ->
  # Return handler
  ({url}, res, next) ->
    # Check for valid extention
    return next() unless extension.test url

    # Normalize path
    filename = path.join dir, url.replace(extension, '.coffee')

    # Check file exists
    return next() unless fs.existsSync filename

    # Parse and return
    try
      content = fs.readFileSync filename, 'utf8'
      res.end coffee.compile content, {filename}
    catch e
      next(e)