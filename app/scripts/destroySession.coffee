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
					<p class='quote'>Do you sit in an office chair for more than six hours a day ? <br>
						<strong>Risk of heart disease is increased by up to 64%</strong>
					</p>
					<div class='email-form'>
						<div id='mc_embed_signup'>
							<form action='//geneguru.us8.list-manage.com/subscribe/post?u=c83b70b914e7d75d6b2187323&amp;id=2b8f19f75d' method='post' id='mc-embedded-subscribe-form' name='mc-embedded-subscribe-form' class='validate' target='_blank' novalidate>
								<h2>Subscribe to our mailing list</h2>
								<div class='indicates-required'>
									<span class='asterisk'>*</span> indicates required
								</div>
								<div class='mc-field-group'>
									<label for='mce-EMAIL'>Email Address  <span class='asterisk'>*</span></label>
									<input type='email' value='' name='EMAIL' class='required email' id='mce-EMAIL'>
								</div>
								<div id='mce-responses' class='clear'>
									<div class='response' id='mce-error-response' style='display:none'></div>
									<div class='response' id='mce-success-response' style='display:none'></div>
								</div>
								<div style='position: absolute; left: -5000px;'><input type='text' name='b_c83b70b914e7d75d6b2187323_2b8f19f75d' tabindex='-1' value=''></div>
								<div class='clear'><input type='submit' value='Subscribe' name='subscribe' id='mc-embedded-subscribe' class='button'></div>
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