###
投票百分比
###
votePercent = (options)->
    # 设置参数
    settings =
        votes: [100, 200, 300]
        groups: '.votes'
        direct: 'v'
        styles:
        	background: '#ccc'
        	position: 'absolute'
        	left: 0
        	bottom: 0
        	zIndex: 10
        	width: 20
        time: 2000
        debug: yes
            
    settings = $.extend settings, options
    
    log = (msg)->
        console.log msg if console? and settings.debug is yes

    int = (n)->
    	parseInt n, 10

    if $(settings.groups).length isnt settings.votes.length
        log "投票数据不一致，请检查votes跟gourps的参数是否正确"

    total = 0
    for vote in settings.votes
        total += vote

    $one = $(settings.groups).first()

    if settings.direct is 'v'
    	pix = int($one.height()) / total
    else
    	pix = int($one.width()) / total

    $(settings.groups).each (i)->
    	changed_pix = int(pix * settings.votes[i])
    	el = $('<div />').css(settings.styles)

    	if settings.direct is 'v'
    		el.css(height: 0)
    		el.animate(
    			height: "#{changed_pix}px"
    		, settings.time)
    	else
    		el.css(width: 0)
    		el.animate(
    			width: "#{changed_pix}px"
    		, settings.time)

    	$(@).css(position: 'relative').append(el)
    	