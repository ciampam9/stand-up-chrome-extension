'use strict'
destroy = {
	init: () ->
		if not document.getElementById('standup-overlay')
			node = document.createElement('div')
			node.id = "standup-overlay"
			node.style.position = "fixed"
			node.style.zIndex = 99999
			node.style.top = 0
			node.style.left = 0
			node.style.right = 0
			node.style.bottom = 0
			node.style.background = "white"
			document.body.appendChild(node)
}

if typeof documet is 'undefined'
	window.addEventListener('DOMContentLoaded', destroy.init())
	#console.log("workss")
else
	destroy.init()
	#console.log('works')