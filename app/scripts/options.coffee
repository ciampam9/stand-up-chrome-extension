'use strict'
class Timer
	@seconds = @seconds
	that = this
	constructor: (interval) ->
		@seconds = interval
	@start: ->
		setInterval(() ->
			if that.seconds is 0
				clearInterval(that.intervalID)
			else
				console.log(that.seconds)
				that.seconds--
		, 1000)
	@tick: ->
		return


timer = new Timer(200)
timer.start()