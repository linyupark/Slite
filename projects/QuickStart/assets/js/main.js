define(function(require) {
    require('../less/main.less');
    var Str = require('../coffee/string.coffee');
    console.log('run in main.js:'+Str.lastChar('654321'));
});
