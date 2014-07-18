'use strict'
destroy = {
	setShadowDom: () ->
		if not document.getElementById('standup-overlay')
			node = document.createElement('div')
			node.id = 'standup-overlay'
			document.body.appendChild(node)
			node.innerHTML = "test"
			return @setShadowDom()
		else
			container = document.querySelector('#standup-overlay')
			shadow = container.createShadowRoot()
			shadow.innerHTML = 
				"<div class='container'>
					<h1>Stand up!</h1>
					<h3>your chair is killing you!</h3>
					<div class='img-container'>
						<img src='http://placekitten.com/300/300' alt='standup logo' width='150' height='150'>
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
	init: () ->
		@setShadowDom()
}

if typeof documet is 'undefined'
	window.addEventListener('DOMContentLoaded', destroy.init())
else
	destroy.init()