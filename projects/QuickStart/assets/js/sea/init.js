seajs.config({
    alias: {
        // 全局模块
        'jquery': _g.assets + 'js/vendor/jquery',
        'coffee': _g.assets + 'js/vendor/coffee',
        'less': _g.assets + 'js/vendor/less',
        'validate': _g.assets + 'js/vendor/validate',
        'slideshowify': _g.assets + 'js/vendor/jquery.slideshowify',
        // 其他资源
        'less-main': _g.assets + 'less/main.less',
        'css-main': _g.assets + 'css/main.css',
        'coffee-string': _g.assets + 'coffee/string.coffee',
        'css-extra': _g.assets + 'css/extra.css',
        // 模块
        'mod-main': 'modules/main'
    },
    preload: [
        'plugin-coffee',
        'plugin-text'
    ]
});

define(function(require, exports, module){
    try{
        require('css-main');
    } catch(err) {
        seajs.config({
            preload: ['plugin-less']
        });
        require.async(['less-main', 'css-extra']);
    } finally {
        require.async(['css-extra']);
    }
});