class Timer
	constructor: (@options) ->
		@current = 'break' #TODO: change this to 1 / 0
		@next    = 'work' #TODO: change this to 1 / 0
		@seconds = @options.duration[@current]
		@running = false

	getDuration: ->
		@seconds

	getInterval: ->
		@current
	start: ->
		previous = @current #TODO: change this to 1 / 0
		@current = @next #TODO: change this to 1 / 0
		@next = previous #TODO: change this to 1 / 0
		@seconds = @options.duration[@current] #TODO: change this to 1 / 0
		return

	init: ->
		that = this
		timerInterval = setInterval(() ->
			if that.seconds is 0
				clearInterval(timerInterval)
				that.onTimerEnd()
				return
			else
				if that.seconds is 60
					that.options.minuteWarning(that.seconds)
				else if that.seconds is 10
					that.options.minuteWarning(that.seconds)
				console.log(that.seconds)
				that.options.displayTimeOnBadge(that.secondsToString(that.seconds--))
				return
		, 1000)
		@start()
		

	onTimerEnd: ->
		@init()
		@options.endOfInterval(@current)
		@options.destroySessions(@current)

	secondsToString: ->
		return if (@seconds >= 60) then parseInt(@seconds / 60) + "m"  else (@seconds % 60) + "s"

options = () ->
	return {
		duration: {
			work: 3600, 
			break: 60
		}
		endOfInterval: (interval) ->
			if interval is 'break'
				chrome.notifications.create("",{
					type: "basic",
					title: "Stand Up Extension",
					message: "STAND UP !",
					iconUrl: "http://placekitten.com/200/200"
				}, (id) -> console.error(chrome.runtime.lastError))
				chrome.browserAction.setBadgeBackgroundColor({color: [255, 0, 0, 255]})
				chrome.browserAction.setBadgeText({text: 'stand up'})
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
		notification: (title, message, iconUrl) ->
			chrome.notifications.create("",{
					type: "basic",
					title: "Stand Up Extension",
					message: message,
					iconUrl: "http://placekitten.com/200/200"
				}, (id) -> console.error(chrome.runtime.lastError))
		minuteWarning: (interval) ->
			if interval is 'break'
				@notification("Stand Up Extension", "60 seconds until Stand Up!")
		tenSecondWarning: (interval) ->
			if interval is 'break'
				@notification("Stand Up Extension", "get ready to stand up in 10 seconds...")
		displayWarningMessage: (interval) ->
			if interval is 'break'
				chrome.notifications.create('', {
					type: "basic",
					title: "Warning",
					message: "Your browser activities will be blocked within the next minute.  Please be prepared.",
					iconUrl: "http://placekitten.com/300/300"
				}, 
				try
					(id) -> console.error(chrome.runtime.lastError)
				catch error
					console.error(error)

				)
		executeScript: (interval) ->
			if interval is 'break'
				return 'scripts/destroySession.js'
			else
				return 'scripts/enableSession.js'
	}

timer = new Timer options()

chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) ->
	if timer.getInterval() is 'break' then chrome.tabs.executeScript(tab.id, {file: 'scripts/destroySession.js'})
)


timer.init()


