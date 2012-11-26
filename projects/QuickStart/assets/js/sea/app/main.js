seajs.config({
	alias: {
		'less-main': ASSETS_ROOT + 'less/main.less',
		'coffee-string': ASSETS_ROOT + 'coffee/string.coffee'
	}
});

define('#app/main', ['jquery', 'less-main', 'coffee-string'], function(require, exports, module) {
	require('less-main');
	var $ = require('jquery');
	var Str = require('coffee-string');
	module.exports = {
		loadJson: function(selector, url){
			$(selector).load(url, { resp: '{ "username": "林小雨" }'});
		},
		bodyFadeIn: function(){
			$('body').animate({'opacity': 1}, 1500);
		},
		printText: function(selector, tpl){
			$(selector).html(tpl);
		}
	};
});
