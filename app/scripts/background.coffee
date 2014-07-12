class Timer
	constructor: (@options) ->
		@current = 'break'
		@next    = 'work'
		@seconds = @options.duration[@current]
		@running = false

	getDuration: ->
		@seconds

	start: () ->
		previous = @current
		@current = @next
		@next = previous
		@seconds = @options.duration[@current]
		return

	init: ->
		that = this
		timerInterval = setInterval(() ->
			if that.seconds is 0
				clearInterval(timerInterval)
				that.onTimerEnd()
				return
			else
				console.log(that.seconds)
				that.seconds--
				return
		, 1000)
		@start()
		

	onTimerEnd: ->
		@init()
		#@options.endOfInterval()
		@options.destroySessions(@current)
		console.log("test")

timer = new Timer {
	
	duration: {
		work: 2,
		break: 2
	}
	
	endOfInterval: () ->
		chrome.notifications.create("",{
			type: "basic",
			title: "Greetings!!",
			message: "Stand the up you lazy bum!",
			iconUrl: "http://placekitten.com/200/200"
		}, (id) -> console.error(chrome.runtime.lastError))
		return

	destroySessions: (interval) ->
		that = this
		chrome.windows.getAll({populate: true}, (windows) ->
			windows.forEach((window) ->
				window.tabs.forEach((tab) ->
					if tab.url.indexOf("chrome://") is -1 and tab.url.indexOf("chrome-devtools://") is -1
						chrome.tabs.executeScript(tab.id, {
							file: that.executeScript(interval)
						})
				)
				return
			)
			return
		)
		return

	executeScript: (interval) ->
		if interval is 'break'
			return 'scripts/destroySession.js'
		else
			return 'scripts/enableSession.js'
}


timer.init()


