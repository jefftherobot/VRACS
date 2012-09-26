var serialPort = require("serialport").SerialPort

serial = new serialPort("/dev/cuaU0" , {baudrate: 9600});

serial.on( "data", function(data) {
  
  var output;

	//	Coerce data into a number
	data = +data;

	//	If data is worth reading and processing
	if ( data && data > 1 ) {
		console.log(data);
	}
  
  
});

serial.on( "error", function( msg ) {
	sys.puts("error: " + msg );
});