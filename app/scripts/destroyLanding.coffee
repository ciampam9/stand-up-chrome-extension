#'use strict'
overlay = document.getElementById('standup-overlay') 
if overlay
	document.body.removeChild(overlay)
else
	console.log("not there")
	