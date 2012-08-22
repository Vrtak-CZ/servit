# Modules
commander = require 'commander'
path = require 'path'

# Arguments
commander.version(require('../package').version)
	.usage('[options] [dir]')
	.option('-a, --address <string>', 'set hostname [localhost]')
	.option('-f, --format <string>', 'connect logger format [dev]', 'dev')
	.option('-p, --port <number>', 'set port number [3000]', 3000)

# Examples,
commander.on '--help', ->
	console.log '''
	\	Examples:

		Serve the current directory

			$ cd /var/www
			$ servit
			Serving /var/www at http://localhost:3000/

		Serve a specific directory

			$ servit /var/www/foo
			Serving /var/www/foo at http://localhost:3000/

		Serve a specific directory with options

			$ servit -a 192.168.0.1 -p 8080 /var/www/foo
			Serving /var/www/foo at http://192.168.0.1:8080/
	'''

# Parse
commander.parse process.argv

# Normalize
commander.dir = path.join process.cwd(), commander.args.shift()

# Servit
require('../src/servit') commander
