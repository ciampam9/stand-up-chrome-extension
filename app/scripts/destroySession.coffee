'use strict'
destroy = {
	init: () ->
		if not document.getElementById('standup-overlay')
			node = document.createElement('div')
			node.id = "standup-overlay"
			document.body.appendChild(node)
			node.innerHTML = 
				"<div class='container'>
					<h1>Stand up!</h1>
					<h3>your chair is killing you!</h3>
					<p class='quote'>Do you site in an office chair for more than six hours a day ? <br>
						<strong>Risk of heart disease is increased by up to 64%</strong>
					</p>
				</div>"

}

if typeof documet is 'undefined'
	window.addEventListener('DOMContentLoaded', destroy.init())
else
	destroy.init()