define('mod-main', ['jquery', 'coffee-string'], function(require, exports, module) {

	var $ = require('jquery');
	var Str = require('coffee-string');

	module.exports = {
		loadJson: function(selector, url){
			$.get(url, { resp: '{ "username": "林小雨" }'}, function(resp){
				$(selector).html(resp.username);
			});
		},
		bodyFadeIn: function(){
			$('body').animate({'opacity': 1}, 1500);
		},
		printText: function(selector, tpl){
			$(selector).html(tpl);
		},
		Str: Str
	};

});