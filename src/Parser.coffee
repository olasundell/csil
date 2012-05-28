{Out} = require './symbols/Out'
{StringSymbol} = require './symbols/StringSymbol'
{Newline} = require './symbols/Newline'
{EOF} = require './symbols/EOF'

ruleset =
	Out: [ StringSymbol ],
	StringSymbol: [ Newline, EOF ],
	Newline: [ EOF, Out ],
	EOF: []
#	scalar: [ @newline, @operation ],
#	assignment: [ @scalar, @identifier ],
#	operation: [ @scalar, @identifier ],
#	identifier: [ @newline, @operation ]
#	dquote: [ @ ]

class Parser
	constructor: ->

	parse: (states) ->
		if states.length is 0
			throw "unexpected end reached"

		return @parseIterate(states.shift(), states)

	parseIterate: (currentState, states) ->
		console.log "currentState: " + currentState + " and states: " + states
		if currentState instanceof EOF
			return
		if states.length is 0
			throw "unexpected end reached in iteration"

		nextState = states.shift()

		for klass in ruleset[currentState]
			if nextState instanceof klass
				foo = true

		if foo is false
			throw "parsing error"

		return @parseIterate(nextState, states)

exports.Parser = Parser
