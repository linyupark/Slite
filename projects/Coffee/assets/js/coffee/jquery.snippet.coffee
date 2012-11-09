$ = this.jQuery

###
图片自动缩放
###
imgResize = ($container, options)->
    # 设置参数
    settings =
        width: 600                  # 超过尺寸则缩小
        resizeTo: 550               # 缩小到多少尺寸
        inAjax: no
        debug: no
        touch: -> $(@).width('auto')
            
    settings = $.extend settings, options
    
    log = (msg)->
        console.log msg if console? and settings.debug is yes
        
    resize = ->
        $container.find('img').each ->
            if +$(@).width() > settings.width
                $(@).width settings.resizeTo
                $(@).bind 'click', settings.touch
            
    $(window).load -> resize()
    $('img', 'body').load -> resize() if settings.inAjax is yes
        

###
滚动到顶部
http://jsfiddle.net/linyupark/VA5ww/
###
scrollTop = (options)->
    # 设置参数
    settings =
        $btn: $('#scrollTop')
        span: 0                     # 离开多少距离就显示
        target: 0                   # 回滚到那里
        smooth: 0                   # 平滑移动
        styles: 
            position: 'fixed'
            cursor: 'pointer'
            right: 100
            bottom: 100
            display: 'none'
        finish: -> log '滚动完毕!'
        debug: no
            
    settings = $.extend settings, options
    
    log = (msg)->
        console.log msg if console? and settings.debug is yes
    
    # 环境确认
    if $.type(exeOnce) isnt 'function'
        log '请引入 exeOnce 函数！'
        return false
    
    # 确保有滚动对象
    if settings.$btn.length is 0
        settings.$btn = $('<div id="scrollTop" />').css settings.styles
        $('body').append settings.$btn
        
    # 滚动对象事件绑定
    settings.$btn.bind 'click', ->
        # 非平滑
        if settings.smooth is 0
            window.scrollTo 0, settings.target
            settings.finish()
        # 平滑，smooth越大越慢
        else
            style =
                scrollTop: settings.target
            $('html, body')
            .stop()
            .animate(style, +settings.smooth, exeOnce(settings.finish))
    
    $(window).bind 'scroll', ->
        span = $(@).scrollTop()
        if span > settings.span # 出现回滚
            settings.$btn.fadeIn()
        else
            settings.$btn.fadeOut()


###
让某函数只执行一次
###
exeOnce = (fn)-> ->
    try 
        fn.apply @, arguments
    catch e
        # console.log e.message if console?
    finally
        fn = null
        

###
循环读取某内容显示
<div id="msg"></div>​
###
loopData = ($display, options={})->
    
    # 设置参数
    settings =
        format: 'json'
        method: 'get'
        jsonKey: 'resp'
        time: 1000              # 间隔多久更新一次
        url: '/echo/json/'
        debug: no
        debugData:              # jsfiddle.net里的ajax测试数据
            html: 'test data'
            json: '{"resp":"test data"}'
            delay: 2
    
    settings = $.extend settings, options
    
    log = (msg)->
        console.log msg if console? and settings.debug is yes
    
    # 检测运行条件
    if $display.length is 0
        log '$display 未指定正确'
    
    # 获取数据
    fetch = ->
        params = 
            url: settings.url
            type: settings.method
            dataType: settings.format
            data: settings.debugData
            success: (data)->
                log data
                if settings.format is 'html'
                    $display.html data
                else
                    $display.html data[settings.jsonKey]
        $.ajax params
                
    timeoutLoop = ->
        fetch()
        
        if settings.debug is no # 测试环境只执行一次
            setTimeout ->
                timeoutLoop()
            , settings.time
        
    timeoutLoop()
    

###
输入框文字限制
<form>
<textarea id="text_input"></textarea>
<div id="limit"></div>
<input type="submit" value="提交" />
</form>​
###
textareaLimit = ($textarea, options={})->
    
    # 设置参数
    settings =
        $tips: $('#limit') # 显示限制字数
        $btn: $(':submit') # 限制提交按钮
        tag: 'span' # 限制字数包围的标签
        color: 'red' # 超过限制后显示的颜色
        limit: 140
        debug: no
    
    settings = $.extend settings, options
    
    log = (msg)->
        console.log msg if console? and settings.debug is yes
    
    # 检测运行条件
    if $textarea.length is 0
        log '$textarea 未指定正确'
        
    if settings.$tips.length is 0
        log '$tips 未指定正确'
        
    if settings.$btn.length is 0
        log '$btn 未指定正确'
    
    # 更改提示信息
    getTips = (n)->
        if n < 0
            settings.$btn.attr 'disabled', 'disabled'
            settings.$btn.css 'opacity', 0.6
            "已经超过 <#{settings.tag} style='color:#{settings.color}'>#{-n}</#{settings.tag}> 字"
        else
            settings.$btn.removeAttr 'disabled'
            settings.$btn.css 'opacity', 1
            "还可以输入 <#{settings.tag}>#{n}</#{settings.tag}> 字"
        
    check = ->
        cur_txt_len = $textarea.val().length
        n = settings.limit - cur_txt_len
        settings.$tips.html getTips(n)
    
    # 先运行一次显示出信息
    check()
    
    # 兼容鼠标粘贴模式
    # setInterval ->
        # check()
    # , 100
    
    # 绑定键盘模式
    $textarea.bind 'keyup', -> check()
    
    
    
    
    
    
    
    
