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

Platform.resourceDir.postln;

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

	"USB Ports".postln;
	SerialPort.listDevices;
	"-----".postln;

	SerialPort.devicePattern = "/dev/ttyUSB*";
	numSerialPorts = SerialPort.devices.size + 1;

	avgBufferSize = 5;
	distanceValues = Array.fill(numSerialPorts, 0);
	distanceBusses = Array.fill(numSerialPorts, {Bus.control(s)});

	(0..(numSerialPorts-1)).do({ |index|

		var serialRoutineFunc = {
			var port, byte, str, setColor;

			if(index == 0,
				{
					port = SerialPort(
						"/dev/ttyACM0",
						baudrate: 9600,
						crtscts: true);
				},
				{
					port = SerialPort(
						"/dev/ttyUSB" ++ (index-1),
						baudrate: 9600,
						crtscts: true);
				}
			);

			/*setColor = { arg r, g, b;
			var rSum, rAvg, gSum, gAvg, bSum, bAvg;

			if(rValues[index].size < (avgBufferSize + 1), {
			rValues[index].add(r);
			gValues[index].add(g);
			bValues[index].add(b);
			}, {
			rValues[index] = rValues[index].shift(1, filler: r);
			gValues[index] = gValues[index].shift(1, filler: g);
			bValues[index] = bValues[index].shift(1, filler: b);
			});

			rSum = 0;
			rValues[index].do{ arg item, i;
			rSum = rSum + item;
			};
			rAvg = rSum / rValues[index].size;

			gSum = 0;
			gValues[index].do{ arg item, i;
			gSum = gSum + item;
			};
			gAvg = gSum / gValues[index].size;

			bSum = 0;
			bValues[index].do{ arg item, i;
			bSum = bSum + item;
			};
			bAvg = bSum / bValues[index].size;

			case
			{(rAvg > gAvg) && (rAvg > bAvg)} {colorStates[index] = 0}
			{(gAvg > rAvg) && (gAvg > bAvg)} {colorStates[index] = 1}
			{(bAvg > rAvg) && (bAvg > gAvg)} {colorStates[index] = 2};

			colorBusses[index].set(colorStates[index]);
			};*/

			inf.do{
				if(port.read==10, {
					str = "";
					while({byte = port.read; byte !=13 }, {
						str= str++byte.asAscii;
					});
					if(str.contains("|"), {
						var arr = str.split($|);

						if(arr.size < 4,
							{
								[index, "Bad data"].postln;
							},
							{
								distanceValues[index] = arr[3].asFloat;
								distanceBusses[index].set(distanceValues[index]);
							}
						);
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
			trackBuffer = Buffer.read(s, Platform.resourceDir ++ file ++ ".wav", action: {
				length = (trackBuffer.numFrames / trackBuffer.numChannels) / trackBuffer.sampleRate;
				[file, length].postln;
			});

			SynthDef.new(file, {
				Out.ar([0,1], PlayBuf.ar(2, trackBuffer, doneAction:2));
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

	// Change randomly, will be replaced with serial port reading
	Routine.run {
		{
			newLength = [0.5, 1, 2, 3].choose;
			iChanging = [0, 1, 2, 3].choose;
			rates[iChanging] = newLength;
			rates.postln;
			4.wait;
		}.loop
	}

});

/*(
var tempoClock, callFunction, checkFunction, currentNote, hitNote, hasInput, trackBuffer, synth, files, file, length;

files = ["bellA", "bellC", "bellF", "bellG"];

Routine.run {
s.bootSync;

for(0, files.size- 1, {
arg i;
file = files[i];
trackBuffer = Buffer.read(s, "/Users/rytrose/Desktop/" ++ file ++ ".wav", action: {
length = (trackBuffer.numFrames / trackBuffer.numChannels) / trackBuffer.sampleRate;
[file, length].postln;
});

SynthDef.new(file, {|out = #[0,1]|
Out.ar(out, PlayBuf.ar(2, trackBuffer));
}).send(s);

s.sync;
});
};

// Set tempo
tempoClock = TempoClock.new(1);

callFunction = {
// Choose what note to play randomly
currentNote = [0, 1, 2, 3].choose;
["Current note", currentNote].postln;

// Play note
synth = Synth.new(files[currentNote], [\out, [0,1].choose]);

// Reset input states
hitNote = -1;
hasInput = false;

// Check after time allotted
tempoClock.schedAbs(tempoClock.beatsPerBar + tempoClock.beats, checkFunction);
};

checkFunction = {
if(~hitNote == currentNote,
// Correct, play again
{"Correct!".postln; tempoClock.play(callFunction);},
// Incorrect, stop
{"You have lost!".postln;});
};

tempoClock.play(callFunction);

)

~hitNote = 3.;*/