var express = require("express")
  , app = express.createServer()
  , io = require('socket.io').listen(app)
  , serialPort = require("serialport").SerialPort;

io.set('log level', 2);
serial = new serialPort("/dev/cuaU0" , {baudrate: 9600});
app.listen(1337);

app.configure(function(){
  app.use(express.static(__dirname + '/www'));

});

io.sockets.on('connection', function (client) {
	// This will only fire when a client has connected
	// Do some stuff when connected to a client
  client.emit('connection', {success: '1'});
  
  client.on('message', function (data) { 
		// Do some stuff when you recieve a message
		serial.write(data);
		console.log(data);
  });
  client.on('disconnect', function () { 
		console.log('Client disconnected');
  });
});