servit
======

The stupid development server. Fork of [workit][workit]

- Reloads browser on source-file change.
- Serves [CoffeeScript][coffee], [EJS][ejs], and [Stylus][stylus] like a champ.
- Compiled output sent directly to browser for a pristine working directory.
- No preprocessor caching so you're guaranteed to load the freshest code.

Built with [Connect][connect], [Socket.io][socket-io], [Commander.js][commander], and
[watchr][watchr]. Inspired by visionmedia's [serve][serve] and nodejitsu's
[http-server][http-server].

Installation
------------

Via [npm](http://npmjs.org/):

	$ npm install -g servit

Usage
-----

```
	Usage: servit [options] [dir]

	Options:
		-h, --help				output usage information
		-V, --version			output the version number
		-a, --address <string>	set hostname [127.0.0.1]
		-f, --format <string>	connect logger format [dev]
		-p, --port <number>		set port number [3000]

	Examples:

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
```

Features
--------

### Preprocessing

`servit` transparently compiles `.coffee`, `.ejs`, and `.styl` files and sends
the output directly to the browser. No rendered files are written to disk, so
your working directory is left in a pristine state.

File extensions are taken literally. If you request `.ejs`, you'll get EJS:

`$ curl http://localhost:3000/foo.ejs`:

```html
	<!DOCTYPE html>
	<title>Hello world</title>
	<link rel="stylesheet" href="foo.css">
	<script src="connect-reload.js"></script>
	<script src="foo.js"></script>
	<% include someAnotherTemplate %>
```

If you want the slightly-more-useful compiled html, request `.htm` or `.html`
instead:

`$ curl http://localhost:3000/foo.html`:

```html
	<!DOCTYPE html>
	<title>Hello world</title>
	<link rel="stylesheet" href="foo.css">
	<script src="connect-reload.js"></script>
	<script src="foo.js"></script>
	<p>Some another template content</p>
```

Same goes for `.coffee` vs `.js` and `.styl` vs `.css`.

### Auto-reload

To enable automatic reloading of a page when a file in your project is created
or changed, simply include the virtual `connect-reload.js` in your markup:

```html
	<script src="connect-reload.js"></script>
```

License
-------

(The MIT License)

Copyright (c) Patrik Votoček &lt;patrik@votocek.cz&gt;  
Copyright (c) Shannon Moeller &lt;me@shannonmoeller.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[workit]: https://github.com/shannonmoeller/workit
[coffee]: http://coffeescript.org/
[commander]: http://visionmedia.github.com/commander.js/
[connect]: http://senchalabs.org/connect/
[watchr]: https://github.com/bevry/watchr/
[http-server]: https://github.com/nodeapps/http-server/
[ejs]: https://github.com/visionmedia/ejs
[serve]: https://github.com/visionmedia/serve/
[socket-io]: http://socket.io/
[stylus]: http://learnboost.github.com/stylus/
