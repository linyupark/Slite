Slite
===============
Slite 是基于Python+Bottle+jinja2的一套简易的前端页面展示平台。


安装、运行
---------------
1. 安装Python环境
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
					|-...
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

