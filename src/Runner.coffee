{Lexer} = require './Lexer'
{Parser} = require './Parser'
util = require 'util'

class Runner
	constructor: ->
		util.puts "Creating a runner."
		lexer = new Lexer
		states = lexer.parsefile("")
		parser = new Parser
		parser.parse(states)

new Runner()
