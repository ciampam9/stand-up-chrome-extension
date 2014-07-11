class Timer
	constructor: (@options) ->
		@current = 'work'
		@next    = 'break'
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
		@options.endOfInterval()
		@options.onCreate(@current)
		console.log("test")
 
timer = new Timer {
	duration: {
		work: 5,
		break: 2
	}
	
	endOfInterval: () ->
		chrome.notifications.create("",{
		type: "basic",
		title: "Greetings!!",
		message: "Stand the fuck up you lazy bum!",
		iconUrl: "http://placekitten.com/200/200"}, (id) -> console.error(chrome.runtime.lastError))
	onCreate: (interval) ->
		bomb = new Nuke()
		bomb.detonate()
		return
}

class Nuke
	constructor: () ->

	detonate: () ->
		windows = chrome.windows.getAll({populate: true}, (windows) ->
			for win in windows
				tabs = windows[win].tabs
				for tab in tabs
					@bomb(action, tabs[tab])
		)
	bomb: (action, tab) ->
		if typeof document is 'undefined'
			window.addEventListener('DOMContentLoaded', @createOverlay)
		else
			@createOverlay

	createOverlay: () ->
		x = document.createElement("div")
		document.x.style.position = "absolute"
		document.x.style.top = 0
		document.x.style.left = 0
		document.x.style.right = 0
		document.x.style.bottom = 0
		document.x.style.zIndex = 0
		document.x.style.backgroundColor = "white"
		document.body.appendChild(x)
	
timer.init()



