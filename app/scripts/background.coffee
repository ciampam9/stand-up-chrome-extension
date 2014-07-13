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
				that.options.displayTimeOnBadge(that.secondsToString(that.seconds--))
				#that.seconds--
				return
		, 1000)
		@start()
		

	onTimerEnd: ->
		@init()
		@options.endOfInterval(@current)
		@options.destroySessions(@current)

	secondsToString: ->
		if @seconds >= 60
			return Math.round(@seconds/60) + "m"
		else
			return (@seconds % 60) + "s"

timer = new Timer {
	
	duration: {
		work: 1800,
		break: 60
	}
	
	endOfInterval: (interval) ->
		if interval is 'break'
			chrome.notifications.create("",{
				type: "basic",
				title: "Greetings!!",
				message: "Stand up you lazy bum!",
				iconUrl: "http://placekitten.com/200/200"
			}, (id) -> console.error(chrome.runtime.lastError))
			chrome.browserAction.setBadgeBackgroundColor({color: [255, 0, 0, 255]})
			chrome.browserAction.setBadgeText({text: 'stand up !!'})
			return
		else
			chrome.browserAction.setBadgeBackgroundColor({color: [0, 0, 0, 0]})
		return

	displayTimeOnBadge: (time) ->
		chrome.browserAction.setBadgeText({text: time})
	destroySessions: (interval) ->
		that = this
		chrome.windows.getAll({populate: true}, (windows) ->
			windows.forEach((window) ->
				window.tabs.forEach((tab) ->
					if tab.url.indexOf("chrome://") is -1 and tab.url.indexOf("chrome-devtools://") is -1
						chrome.tabs.executeScript(tab.id, {
							file: that.executeScript(interval)
						})
						return
				)
				return
			)
			return
		)
		return
	displayWarningMessage: (interval) ->
		if interval is 'break'
			chrome.notifications.create('', {
				type: "basic",
				title: "Warning",
				message: "Your browser activities will be blocked within the next minute.  Please be prepared.",
				iconUrl: "http://placekitten.com/300/300"
			}, (id) -> console.error(chrome.runtime.lastError))
	executeScript: (interval) ->
		if interval is 'break'
			return 'scripts/destroySession.js'
		else
			return 'scripts/enableSession.js'
}


timer.init()


