((f)->
 	if typeof define is 'function'
 		define '#common', [], f
 	else
 		f()
)((require)->
 	_log = (msg)-> 
 		console.log msg if window.console?
 	return
)