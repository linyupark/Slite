define(function(require, exports) {
  
  require('../less/seajs.less?v2')
  
  var $ = require('jq')
  var seajs = require('../coffee/seajs.coffee')
  console.log(seajs)
  
  var string = require('../coffee/string.coffee')
  $('#urlencode').html("?a=a&b=b".urlencode())
  
  var jqs = require('../coffee/jquery.snippet.coffee')
  var pop1 = new jqs.Pop()
  pop1.open('hello~')
  
  exports.string = string

})
