# -*- coding: utf-8 -*-
from bottle import Bottle, jinja2_template, run, TEMPLATE_PATH, request, static_file
import json, os, time

# lesscss
from lesscss.lessc import compile
from lesscss.contrib import console

slite = Bottle()

# 常量
ROOT_PATH = os.path.abspath(os.path.dirname(__file__)).replace('\\', '/')
DICT_NAME = 'index.json'
PORT = 5000

# 资源目录
@slite.get('/static/<project>/<filepath:path>')
def server_static(project, filepath):
    root = '%s/projects/%s/assets/' % (ROOT_PATH, project)
    return static_file(filepath, root=root)

@slite.get('/_static/<filepath:path>')
def server_app(filepath):
    root = '%s/app/' % ROOT_PATH
    return static_file(filepath, root=root)

# 访问上传文件
@slite.get('/upload/<filepath>')
def server_upload(filepath):
    return static_file(filepath, root='%s/upload/' % ROOT_PATH)

# 图标
@slite.get('/favicon.ico')
def show_favicon():
    return static_file('favicon.ico', './')

###########################################################

# 模拟ajax数据传递
@slite.route('/_ajax/<format>', method=['GET', 'POST'])
def ajax_request(format):
    if format == 'html':
        return request.params.get('resp')
    if format == 'json':
        try:
            return json.loads(request.params.get('resp'))
        except:
            return '{"error": "resp传递的json格式有错误，请检查"}'
    
    return 200

# 模拟上传
@slite.post('/_upload')
def upload_request():
    data = request.files.data
    if data and data.file:
        filename = '%s.%s' % (time.time(), data.filename.split('.')[-1])
        outfile = file('%s/upload/%s' % (ROOT_PATH, filename), 'wb')
        raw = data.file.read() # 大文件需要优化此处
        while raw:
            outfile.write(raw)
            raw = data.file.read()
        outfile.close()
        
        return """
        {
            "size: "%d bytes",
            "name": "%s",
            "url": "/upload/%s"
        }
        """ % (len(raw), filename, filename)
        
    return "error"

###########################################################

# 项目列表
@slite.get('/')
def projects():
    
    # 项目目录列表
    project_dirs = os.listdir('./projects')
    
    return jinja2_template('app/app.html',
                           projects=project_dirs)

# 项目页面列表
@slite.get('/<project>')
def pages(project):
    
    # 得到页面文件列表
    pages_dir = './projects/%s/pages' % project
    page_files = os.listdir(pages_dir)
    
    if DICT_NAME in page_files:
        
        # 过滤字典文件
        page_files.remove(DICT_NAME)
        
        # 文件名转中文字典文件载入
        dict_json = json.load(open('%s/%s' %  (pages_dir, DICT_NAME)))
    
    else:
        dict_json = { "pages_index": {} }
    
    return jinja2_template('app/app.html',
                           project=project,
                           pages=page_files,
                           **dict_json)

# 项目某页面
@slite.get('/<project>/<page>')
def page(project, page):
    
    # 设定模版目录
    TEMPLATE_PATH.append('./projects/%s/pages/' % project)
    TEMPLATE_PATH.append('./projects/%s/layouts/' % project)
    
    # less生成css
    less = request.params.get('less')
    less_file = '%s/projects/%s/assets/less/%s.less' % (ROOT_PATH, project, less)
    css_file = '%s/projects/%s/assets/css/%s.css' % (ROOT_PATH, project, less)
    if less and os.path.isfile(less_file):
        print u'生成css!'
        try:
            less_source = open(less_file)
            output = console.Writer(open(css_file, 'w'))
            output.write(compile(less_source.read()))
        except Exception, e:
            print e

    context = { 
        'project': project,
        'page': page,
        'site': 'http://%s' % request.environ.get('HTTP_HOST'),
        'url': request.url, 
        'req': request.params,
        'base': '/%s/' % project
    }
    return jinja2_template(page, **context)


run(slite, host='0.0.0.0', port=PORT, debug=True, reloader=True)




