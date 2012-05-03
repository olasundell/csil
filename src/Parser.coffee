fs = require 'fs'
util = require 'util'

class Parser
	constructor: ->
		@loadruleset()
		@loadsymbols()
		@parsefile()

	loadsymbols: ->
		@symbols = JSON.parse(fs.readFileSync('src/symbols.json').toString())

	loadruleset: ->
		@ruleset = JSON.parse(fs.readFileSync('src/ruleset.json').toString())

	parsefile: (filename) ->
		code = fs.readFileSync('src/csil/hello.csil').toString()
		state = null
		previousState = null
		states = []

		currentToken = ""

		util.puts "starting"

		for c in code
			currentToken = currentToken + c

			if @symbols[currentToken] # reserved word
				util.puts currentToken
				currentToken = ""
			else
				for symbol in @symbols
					util.puts symbol
					if currentToken.match symbol
						util.puts currentToken
						currentToken = ""

#				previousState = state
#				state = @symbols[currentToken]
#
#				if previousState isnt null
#					if not state in @ruleset[previousState]
#						throw "compilation error!"
		util.puts "finished"

parser = new Parser()

#			mappedToken = @symbols[currentToken]
#			if mappedToken isnt null and mappedToken isnt ""

