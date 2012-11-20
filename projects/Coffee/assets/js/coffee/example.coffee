class Book
    
    isbn=title=author=null
    
    # 私有方法
    checkIsbn = (isbn)->
        console.log ''
        
    # 特权方法
    setIsbn: (newIsbn)->
        isbn = newIsbn
        
    # 公共方法
    display: ->
        console.log 'display!'
        
    # 构建
    constructor: (newIsbn)->
        @setIsbn newIsbn
