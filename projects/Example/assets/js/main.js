
// 自动运行的放这里
;$(document).ready(function(){
	SBS.textPlugin.execute(123, {key_1: 'a'});
	console.log(new SBS.textPlugin);
});

/*!
 * 基于jQ的项目基础JS
 * Author: @linyu
 */
(function($){
	
	// 开启关闭调试信息
	(function(debug){
		var methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error', 'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log', 'markTimeline', 'profile', 'profileEnd', 'markTimeline', 'table', 'time', 'timeEnd', 'timeStamp', 'trace', 'warn'],
			length = methods.length,
			func = window.alert;
			
		if(!debug || !window.console)
		{
			var console = window.console = {};
			if(!debug) func = function() {}; 
			while(length--){
				console[methods[length]] = func;
			}
		}
	})(true);
	
	// 创建项目命名空间(Window.xxx)
	SBS = {};
	
	// 项目常量
	SBS.version = '1.0.0';
	
	// 某部件
	SBS.textPlugin = {
		defaults: {
			key_1: 'val_1',
			key_2: 'val_2'
		},
		init: function(){
			this.version = '2.0.0';
			console.log('初始化操作执行！');
		},
		execute: function(el, options){
			var settings = $.extend(this.defaults, options);
			this.init();
			console.log(settings, SBS.version, this.version);
		}
	};
	
	// 某部件2
	SBS.string = {
		repeat: function(str, times){
			return new Array(times).join(str);
		}
	};
	
})(jQuery);



