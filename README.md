Slite
===============
Slite 是基于Python+Bottle+jinja2的一套简易的前端页面展示平台。


安装、运行
---------------
1. 安装Python环境，（注意要设置环境变量）
2. 下载压缩包解压后运行:
		

		>python app.py

		
默认端口为5000，如需修改请打开app.py修改port参数:


		PORT=5000

		
使用过程中目录结构介绍
----------------------		
创建一个项目目录，放置于projects目录下，务必使用英文，如 QuickStart

		
		-projects
			|- QuickStart      				# 项目目录
				|-assets					# 静态资源目录 可通过 /static/项目名/文件名 来访问到
					|-js
						|-vendor			# 一些第三方类库
						|-sea				# SeaJS模块化开发js(推荐使用)
							|-app 			# 项目中的各种模块放置目录
								|-main.js 	# 推荐使用的默认seajs.use模块
					|-css
					|-img
					|-less
						|-base
							|-class.less 	# 常用css class
							|-mixin.less 	# 常用函数
							|-reset.less
						|-element
							|-button.less 	# 项目通用按钮样式
							|-form.less 
							|...
						|-pages 			# 具体某页面的样式定义
						|-main.less			# less 引入文件
					|-...
					|-logo.png				# 用于显示在列表展示用的LOGO图片
				|-layouts					# 布局文件
				|-pages						# 页面存放目录 通过 /项目名/文件名 来访问
					|-index.json			# 文件名跟中文名显示字典
					|-index.html		
					|-....


目录结构可详见 **projects/QuickStart**

页面使用了jinja2模版引擎，一些语法可见：[官方文档](http://jinja.pocoo.org/docs/templates/)
默认绑定的一些模版变量有如下：


		{{ url }}					# 显示当前页面的完整地址
		{{ req.get('?') }}			# 得到get以及post对应?的数据
		{{ site }}					# 包含http的主机地址
		{{ project }}				# 项目名称
		{{ page }}					# 当前页面名称
		{{ base }}  				# (eg: /Example/)
		{{ static }}  				# 静态目录完整url地址
		
		
		
创建一个前端展示项目的步骤
--------------------------
1.在 **projects** 目录下放置好如上面类似的目录结构

2.在 **layouts** 目录下创建一个基础布局文件，内容类似：

		<!DOCTYPE html>
		<html>
		    <head>
		        <meta charset="utf-8">
		        <title>{% block title %}{% endblock %}</title>
		        <meta name="description" content="">
		        <meta name="keywords" content="">
		        <script src="{{ static }}js/sea/sea.js" id="seajsnode"></script>
		        <script type="text/javascript">
		        ASSETS_ROOT = '{{ static }}';
		        seajs.config({
		            alias: {
		                'jquery': ASSETS_ROOT + 'js/vendor/jquery',
		                'coffee': ASSETS_ROOT + 'js/vendor/coffee',
		                'less': ASSETS_ROOT + 'js/vendor/less'
		            },
		            preload: [
		                'plugin-coffee',
		                'plugin-less',
		                'plugin-text'
		            ]
		        });
		        </script>
		        <!--[if lt IE 9]><script src="{{ static }}vendor/html5.js"></script><![endif]-->
		        {% block head %}{% endblock %}
		    </head>
		    <body>
		        <!--[if lt IE 7]><![endif]-->
		        {% block body %}{% endblock %}
		        {% block bottom_js %}{% endblock %}
		    </body>
		</html>

提示：{% block ??? %}{% endblock %} 是ninja2的内容填充区块标识符

3.在 **pages** 下创建一个展示页面，可以继承 layouts 里的某个布局文件，内容类似：

		{% extends "_base" %}

		{% block head %}
		<style type="text/css">
			body{ opacity: 0 }
		</style>
		{% endblock %}

		{% block body %}
		<h1>模拟上传</h1>
		<form action="{{ site }}/_upload" method="post" enctype="multipart/form-data">
		  <input type="file" name="data" />
		  <input type="submit" value="upload" />
		</form>

		<h1>模拟Ajax请求</h1>
		<div id="json"></div>

		<h1>SeaJS的text插件</h1>
		<div id="plugin-text"></div>
		{% endblock %}

		{% block bottom_js %}
		<script type="text/javascript">
		seajs.use([
			'app/main', // 引入 js/sea/app/main.js
			ASSETS_ROOT + 'tpl/intro.tpl' // 引入模版文件
		], function(main, intro){
			var words = 'hello world';
			// 调用main.js中定义的接口
			main.loadJson('#json', '/_ajax/json');
			main.printText('#plugin-text', intro);
			main.bodyFadeIn();
			alert(words+'最后一个字符:' + main.Str.lastChar(words));
		});
		</script>
		{% endblock %}


main.js内容如下


		seajs.config({
			// 别名设置（可覆盖全局）
			alias: {
				'less-main': ASSETS_ROOT + 'less/main.less',
				'coffee-string': ASSETS_ROOT + 'coffee/string.coffee',
				'css-extra': ASSETS_ROOT + 'css/extra.css'
			}
		});

		// #ID, [依赖关系]
		define('#app/main', ['jquery', 'less-main', 'coffee-string', 'css-extra'], function(require, exports, module) {
			require(['less-main', 'css-extra']);  // 分别载入less跟额外的css样式
			var $ = require('jquery');
			var Str = require('coffee-string');
			// 各种开放的接口~
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


4.讲js 跟图片等资源放置在 assets目录下，并通过 {{ site }}/static/项目目录名/资源目录名/文件名 来指向。(static目录名称可以自定义)

使用上传功能
------------
请求地址：/_upload
返回数据的格式：

        {
            "size: 字节数,
            "name": 上传后的名称,
            "url": 访问上传文件的地址
        }

模拟ajax请求
-----------
请求地址：/_ajax/html 或者 /_ajax/json (html,json为格式)
注意：在发送请求的时候传递 resp 数据
返回：resp 发送了什么数据就会返回相同数据
比如

        $.get('/_ajax/html', {resp: '<h1>标题</h1>'}, function(resp){ alert(resp); });

修改静态文件路径显示
--------------------
修改app.py中的ASSET_NAME值


