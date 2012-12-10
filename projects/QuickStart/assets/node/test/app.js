var app = require('express')()
  , server = require('http').createServer(app)
  , io = require('socket.io').listen(server);

server.listen(3000);

io.sockets.on('connection', function (socket) {
  socket.on('q', function (data) {
    if(data.q == '开始'){
  		socket.emit('a', { a: '有什么可以帮助你的吗？（a:有,b:没有）' });
    }
  });
});