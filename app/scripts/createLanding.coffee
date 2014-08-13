'use strict'

class radialTimer
	constructor: (shadow) ->
		self = this
		@seconds = 0
		@count = 0
		@degrees = 0
		@interval = null
		@timerHTML = timerHTML = ""
		@timerContainer = null
		@number = null
		@slice = null
		@pie = null
		@pieRight = null
		@pieLeft = null
		@quarter = null
		@init = (s) ->
			self.timerContainer = shadow.querySelector("#spinner")
			#self.timerContainer.innerHTML = self.timerHTML
			self.number = shadow.querySelector(".n")
			self.slice = shadow.querySelector(".slice")
			self.pie = shadow.querySelector(".pie")
			self.pieRight = shadow.querySelector(".pie.r")
			self.pieLeft = shadow.querySelector(".pie.l")
			self.quarter = shadow.querySelector(".q")
			self.start(s, shadow)

		@start = (s, shadow) ->
			self.seconds = s
			self.interval = window.setInterval(() ->
				self.number.innerHTML = (self.seconds - self.count)
				self.count++
				if self.count > (self.seconds - 1)
					clearInterval(self.interval)
				
				self.degrees = self.degrees + (360 / self.seconds)
				console.log(self.degrees)
				if self.count >= (self.seconds / 2)
					className = "nc"
					console.log(self.slice.classList)
					if self.slice.classList
						self.slice.classList.add(className)
					else
						self.slice.className += ' ' + className
					if not self.slice.classList.contains("mth")
						self.pieRight.style.transform = "rotate(180deg)"
					self.pieLeft.style.transform = "rotate(#{self.degrees}deg)"
					self.slice.classList.add("mth")
					if self.count >= (self.seconds * 0.75)
						self.quarter.parentNode.removeChild(self.quarter)
				else
					self.pie.style.transform = "rotate(#{self.degrees}deg)"
			, 1000)

destroy = {
	content: "<div class='container'>
					<div class='img-container'>
						<div class='radialtimer animated fadeInUp'>
							<div id='spinner'>
								<div class='n'></div>
								<div class='slice'>
									<div class='q'></div>
									<div class='pie r'></div>
									<div class='pie l'></div>
								</div>
							</div>
						</div>
					</div>
					<h1 class='animated fadeInUp'>Stand Up!</h1>
				</div>"
	setShadowDom: () ->
		that = this
		if not document.getElementById('standup-overlay')
			node = document.createElement('div')
			node.id = 'standup-overlay'
			document.body.appendChild(node)
			#node.innerHTML = "test"
			return @setShadowDom()
		else
			container = document.querySelector('#standup-overlay')
			shadow = container.createShadowRoot()
			shadow.innerHTML =  that.content
			return shadow
				
	init: () ->
		shadow = @setShadowDom()
		timer = new radialTimer(shadow)
		timer.init(30)
}

if typeof documet is 'undefined'
	
	window.addEventListener('DOMContentLoaded', destroy.init())
else
	destroy.init()




