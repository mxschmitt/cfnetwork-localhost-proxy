var socks = require('socksv5');

var srv = socks.createServer(function(info, accept, deny) {
  var socket = accept(true)
  var body = 'Hello from the Socks proxy';
  socket.end([
    'HTTP/1.1 200 OK',
    'Connection: close',
    'Content-Type: text/plain',
    'Content-Length: ' + Buffer.byteLength(body),
    '',
    body
  ].join('\r\n'));
});
srv.listen(1080, 'localhost', function() {
  console.log('SOCKS server listening on port 1080');
});

srv.useAuth(socks.auth.None());