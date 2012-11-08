###
最后一个字符
###
lastChar = (str)-> str.charAt str.length - 1


###
去除字符串左右空格
###
trim = (str)-> str.replace /^\s+|\s+$/g, ''
ltrim = (str)-> str.replace /^\s+/g, ''
rtrim = (str)-> str.replace /\s+$/g, ''


###
扩展String！是否包含某字符
###
unless String::contains then String::contains = (str)-> @indexOf(str) != -1


###
创建一个随机字符串ID
###
uniqueID = (len=8)->
    id = ""
    while id.length < len
        id += Math.random().toString(36).substr(2)
    id.substr 0, len


###
扩展String！重复显示字符串
###
unless String::repeat then String::repeat = (times)-> Array(times).join @



###
判断是否为Int
###
isInt = (str)-> str.match(/[0-9 -()+]+$/) isnt null



###
扩展String！字符串内容倒叙
###
unless String::reverse then String::reverse = -> @.split('').reverse().join('')


###
提取中文
###
fetchCN = (str)-> str.replace /[u4e00-u9fa5]/g, ''


###
过滤中文
###
cleanCN = (str)-> str.replace /[^u4e00-u9fa5]/g, ''


###
是否全中文
###
isCn = (str)-> /[u4e00-u9fa5]/.test(str) is no



###
过滤html标签
###
cleanHTML = (html)->
    div = document.createElement 'div'
    div.innerHTML = html
    div.textContent or div.innerText or ''



###
url en|decode 缩写
###
unless String::urlencode then String::urlencode = -> encodeURIComponent @
unless String::urldecode then String::urldecode = -> decodeURIComponent @



###
获取URL地址中某参数值
###
getQuery = (name, url=window.location.href)-> new RegExp("[\\?&amp;]#{name}=([^&amp;#]*)").exec(url)[1]



###
高亮
###
highlight = (str, words=[], tag='span')->
    return false if words.length is 0
    for w in words
        re = new RegExp w, 'g'
        str = str.replace re, "<#{tag} class='highlight'>$&</#{tag}>" if re.test str
    str


###
取消高亮
###
unhighlight = (str, tag='span')->
    re = new RegExp "(<#{tag} class='highlight'>|<\/#{tag}>)", 'g'
    str.replace re, '' if re.test str



###
概要
###
summary = (str, limit, tail='...')->
    str = str.split ''
    if str.length > limit
        str = str[0...limit]
        str.push(tail)
    str.join ''
    








