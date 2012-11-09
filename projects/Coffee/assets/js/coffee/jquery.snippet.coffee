$ = this.jQuery


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
    
    
    
    
    
    
    
    
