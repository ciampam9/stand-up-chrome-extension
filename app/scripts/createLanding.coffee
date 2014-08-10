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
					<h1>Stand up!</h1>
					<h3>your chair is killing you!</h3>
					<div class='img-container'>
						<div class='radialtimer'>
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
					<p class='quote'>Do you sit in an office chair for more than six hours a day ? <br>
						<strong>Risk of heart disease is increased by up to 64%</strong>
					</p>
					<div class='email-form'>
						<div id='mc_embed_signup'>
							<form action='//geneguru.us8.list-manage.com/subscribe/post?u=c83b70b914e7d75d6b2187323&amp;id=2b8f19f75d' method='post' id='mc-embedded-subscribe-form' name='mc-embedded-subscribe-form' class='validate' target='_blank' novalidate>
								<h3>Get more free apps and resources to lead a happier and healthier life</h3>
								<div class='mc-field-group'>
									<input type='email' value='' name='EMAIL' class='required email' id='mce-EMAIL' placeholder='email address'>
								</div>
								<div id='mce-responses' class='clear'>
									<div class='response' id='mce-error-response' style='display:none'></div>
									<div class='response' id='mce-success-response' style='display:none'></div>
								</div>
								<div style='position: absolute; left: -5000px;'><input type='text' name='b_c83b70b914e7d75d6b2187323_2b8f19f75d' tabindex='-1' value=''></div>
								<div class='clear'><input type='submit' value='Let&#039;s do this!' name='subscribe' id='mc-embedded-subscribe' class='button'></div>
							</form>
						</div>
					</div>
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
		timer.init(60)
}

if typeof documet is 'undefined'
	
	window.addEventListener('DOMContentLoaded', destroy.init())
else
	destroy.init()




