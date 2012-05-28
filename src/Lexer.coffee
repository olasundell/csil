fs = require 'fs'
util = require 'util'

{Out} = require './symbols/Out'
{StringSymbol} = require './symbols/StringSymbol'
{EOF} = require './symbols/EOF'

regexp = "regexp"
constant = "constant"

symbols =
#	{ "=": assignment } ,
#	{ operation: "[+-*/]" } ,
#	{ identifier: "[a-z]+" },
#	{ scalar: "[0-9]+" },
	out:
		className: "Out"
		symbolType: constant
		constant: "out"
	dquote:
		className: "DQuote"
		symbolType: constant
		constant: '"'
	string:
		className: "StringSymbol"
		symbolType: regexp,
		regex: /".*"/
	#	whitespace:
	#		className: "none",
	#		symbolType: regexp,
	#		regex: /[ ]/
	#	{ lparen: "(" },
	#	{ rparen: ")" },
	newline:
		className: "none"
		symbolType: constant
		constant: "\n"


class Lexer
	constructor: ->
		util.puts "Creating a Lexer"

	loadsymbols: ->
		#		@symbols = JSON.parse(fs.readFileSync('src/symbols.json').toString())

	loadruleset: ->
		#		@ruleset = JSON.parse(fs.readFileSync('src/ruleset.json').toString())

	parsefile: (filename) ->
		code = fs.readFileSync('src/csil/hello.csil').toString()
		previousState = null

		currentToken = ""
		@states = []
		@currentState = "string"

#		util.puts "starting"

		for c in code
			currentToken = currentToken + c
			for expr, info of symbols
				if (constant is info.symbolType and info.constant is currentToken) or
				(regexp is info.symbolType and info.regex.test currentToken)
					currentToken = @pushstate(currentToken, info.className)

		@states.push(new EOF)

#		util.puts "finished"
#		util.puts @states

		return @states

	pushstate: (currentToken, className) ->
		switch className
			when "Out" then stateInstance = new Out
			when "StringSymbol" then stateInstance = new StringSymbol currentToken.trim()
			else stateInstance = undefined

		if stateInstance isnt undefined
			util.puts "pushing " + stateInstance
			@states.push(stateInstance)
			@currentState = currentToken

		return ""

exports.Lexer = Lexer
