# Modules
helper = require './helper'
ejs = require 'ejs'

# Compiler
compile = (filename, data, cb) ->
	cb null, ejs.compile(data, {
		filename: filename
	})()

# Export middleware
module.exports = (dir) ->
	helper dir, /\.html?$/, '.ejs', compile
