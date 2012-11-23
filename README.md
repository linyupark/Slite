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
创建一个项目目录，放置于projects目录下，务必使用英文，如 Example

		
		-projects
			|- Example      		# 项目目录
				|-assets			# 静态资源目录 可通过 /static/项目名/文件名 来访问到
					|-js
					|-css
					|-img
					|-less          # 如需要less则将文件放入此文件夹，生成指定less文件需在url中加入query请求less=文件名（不要.less后缀）
					|-...
					|-logo.png		# 用于显示在列表展示用的LOGO图片
				|-layout			# 布局文件
				|-pages				# 页面存放目录 通过 /项目名/文件名 来访问
					|-index.json	# 文件名跟中文名显示字典
					|-index.html		
					|-....

					
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
1. 在 **projects** 目录下放置好如上面类似的目录结构
2. 在 **layouts** 目录下创建一个基础布局文件，内容类似：

		<!DOCTYPE html>
		<html>
		    <head>
		        <meta charset="utf-8">
		        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		        <title>{% block title %}{% endblock %}</title>
		        <meta name="description" content="">
		        <meta name="viewport" content="width=device-width">
		        <link rel="stylesheet" href="{{ site }}/static/Example/css/normalize.css">
		        <link rel="stylesheet" href="{{ site }}/static/Example/css/main.css">
		        <script src="{{ site }}/static/Example/js/vendor/jquery-1.8.2.min.js"></script>
		        <script src="{{ site }}/static/Example/js/vendor/modernizr-2.6.2.min.js"></script>
		    </head>
		    <body>
		        {% block body %}
		        {% endblock %}
		    </body>
		</html>

提示：{% block ??? %}{% endblock %} 是ninja2的内容填充区块标识符

3. 在 **pages** 下创建一个展示页面，可以继承 layouts 里的某个布局文件，内容类似：

		{% extends 'base.html' %}
		
		{% block title %}测试首页{% endblock %}
		
		{% block body %}
		Hello Slite Example!
		{% endblock %}

4. 讲js 跟图片等资源放置在 assets目录下，并通过 {{ site }}/static/项目目录名/资源目录名/文件名 来指向。


如何让less文件生成为css文件
--------------------------
如在less目录下有一 **test.less** 文件，则在页面地址中加入：

        http://.........html?less=test
        
        
则会自动在 **assets/css** 下生成 **test.css** 文件


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


