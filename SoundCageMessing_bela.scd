/**
This script exemplifies the use of SuperCollider on Bela.
When a project contains a `_main.scd` file, `sclang` is started
and the content of the file is executed.
If you want to interact with SuperCollider running on the board
from within the SuperCollider IDE on your computer, check out
the 12-SuperCollider/remote examples instead.
Those files also include more code examples to interface with
Bela-specific UGens.
*/

var fileDir = Platform.resourceDir ++ "/sounds/";

s = Server.default;

s.options.numAnalogInChannels = 8;
s.options.numAnalogOutChannels = 8;
s.options.numDigitalChannels = 16;

s.options.blockSize = 16;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;

s.options.postln;

s.waitForBoot({
	var trackBuffer, synth, length, files, file, rates, newLength, iChanging, special, specialRate, avgBufferSize, distanceValues, colorStates, numSerialPorts, distanceBusses;

	special = false;
	files = ["bellA", "bellC", "bellF", "bellG", "clap"];
	rates = [2, 2, 2, 2];

	SerialPort.devicePattern = "/dev/ttyUSB*";
	numSerialPorts = SerialPort.devices.size;

	"USB Ports".postln;
	SerialPort.listDevices;
	"-----".postln;

	avgBufferSize = 5;
	distanceValues = Array.fill(numSerialPorts, 0);
	distanceBusses = Array.fill(numSerialPorts, {Bus.control(s)});

	(0..(numSerialPorts-1)).do({ |index|

		var serialRoutineFunc = {
			var port, byte, str, setColor;

			if(index == 0,
				{
					port = SerialPort(
						"/dev/ttyUSB0",
						baudrate: 9600,
						crtscts: true);
				},
				{
					port = SerialPort(
						"/dev/ttyUSB" ++ (index),
						baudrate: 9600,
						crtscts: true);
				}
			);

			inf.do{
				if(port.read==10, {
					var distValue;
					str = "";
					while({byte = port.read; byte !=13 }, {
						str= str++byte.asAscii;
					});

					distValue = str.asFloat;
					if(distValue != 150, {
						var zoneRate = (distValue/30.0).floor + 1;
						rates[index] = zoneRate;
					});
				});
			};
		};

		Routine.run(serialRoutineFunc);
	});

	Routine.run {
		s.bootSync;

		for(0, 4, {
			arg i;
			file = files[i];
			trackBuffer = Buffer.readChannel(s, fileDir ++ file ++ ".wav", action: {
				length = (trackBuffer.numFrames / trackBuffer.numChannels) / trackBuffer.sampleRate;
				[file, length].postln;
			}, channels:[0]);

			s.sync;

			SynthDef.new(file, {
				AnalogOut.ar(i, (PlayBuf.ar(1, trackBuffer, doneAction:2)+1.0)/ 2.0);
			}).send(s);

			s.sync;
		});
	};

	for(0, 3, {
		arg i;
		Routine.run {
			{
				synth = Synth.new(files[i]);
				rates[i].wait;
				["playing bell", i, rates[i]].postln;
			}.loop
		};
	});

	Routine.run {
		{
			// Add hidden state conditions to this
			if(rates[0] / rates[1] == 0.5,
				{special = true},
				{special = false}
			);
			if(special,
				{
					// Add less terrible hidden state sounds to this
					synth = Synth.new("clap");
				}
			);
			0.2.wait;
		}.loop
	};

	// // Change randomly, will be replaced with serial port reading
	// Routine.run {
	// 	{
	// 		newLength = [0.5, 1, 2, 3].choose;
	// 		iChanging = [0, 1, 2, 3].choose;
	// 		rates[iChanging] = newLength;
	// 		rates.postln;
	// 		4.wait;
	// 	}.loop
	// }

});

0.range(0.05, 0.95)
