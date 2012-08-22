# Modules
hound = require 'hound'
path = require 'path'
socketio = require 'socket.io'
util = require 'util'

# Prozac
debounce = (fn, timeout) ->
	return ->
		clearTimeout timeout
		timeout = setTimeout fn, 20

# Client
client = ->
	# Honor address and port values
	server = '//%s:%s/'

	# Reload handler
	reload = ->
		io.connect(server).on 'connect-reload', ->
			document.location.reload true

	# Are we done yet?
	return reload() if io?

	# Lazy load socket.io
	script = document.createElement('script')
	script.src = server + 'socket.io/socket.io.js'
	script.onload = reload
	target = document.getElementsByTagName('script')[0]
	target.parentNode.insertBefore script, target.nextSibling

# Browserify
client = "(#{client}());"

# Export middleware
module.exports = ({address, dir, port, server}) ->
	# Start watching files and open socket
	dog = hound.watch dir
	io = socketio.listen server, 'log level': 0

	# Watcher ignore some folders and files
	for pattern in ['.svn', '.git', '.hg', 'CVS', '.DS_Store']
		dog.unwatch "#{dir}/#{pattern}"

	# Reasonable emitter
	emit = debounce ->
		io.sockets.emit 'connect-reload'

	# Reload emitter
	reload = (file) ->
		# Ignore hidden files
		emit() if path.basename(file).indexOf '.'

	# Bind handler
	dog.on 'create', reload
	dog.on 'change', reload

	# Return middleware
	({url}, res, next) ->
		# Handle reloads
		return next() unless url is '/connect-reload.js'

		# RAM for the win
		res.setHeader 'Content-Type', 'text/javascript'
		res.end util.format(client, address, port)
