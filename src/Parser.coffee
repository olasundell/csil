fs = require 'fs'

class Parser
	readfile: (filename) ->
		fs.readFile filename parsecode(err, code)

	parsecode: (err, code) ->
		throw err if err and err.code isnt 'ENOENT'
		return code


