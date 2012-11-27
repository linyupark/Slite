seajs.config({
    alias: {
        // 全局模块
        'jquery': _g.assets + 'js/vendor/jquery',
        'coffee': _g.assets + 'js/vendor/coffee',
        'less': _g.assets + 'js/vendor/less',
        // 其他资源
        'less-main': _g.assets + 'less/main.less',
        'coffee-string': _g.assets + 'coffee/string.coffee',
        'css-extra': _g.assets + 'css/extra.css',
        // 模块
        'mod-main': 'modules/main'
    },
    preload: [
        'plugin-coffee',
        'plugin-less',
        'plugin-text'
    ]
});

define(function(require, exports, module){
    require.async(['less-main', 'css-extra']);
});