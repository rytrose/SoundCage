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
Server.killAll
ServerOptions.outDevices
s.options.numOutputBusChannels

(
var fileDir =  "/Users/avneeshsarwate/SoundCage/";
// var fileDir = "/Users/rytrose/OneDrive - Georgia Institute of Technology/GTCMT/SoundCage/";

s = Server.default;
// s = Server.new('cage', NetAddr("localhost", 54321));

s.options.device = ServerOptions.outDevices[1];
s.options.numOutputBusChannels = 4;
/*s.options.numAnalogInChannels = 8;
s.options.numAnalogOutChannels = 8;
s.options.numDigitalChannels = 16;

s.options.blockSize = 16;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;*/

s.options.postln;

s.waitForBoot({
    var trackBuffer, synth, length, files, file, rates, newLength, iChanging, special, specialRate, avgBufferSize, distanceValues, colorStates, numSerialPorts, distanceBusses, rawDistances, usbPorts;
    var readValues;

    special = false;
    files = ["bellA", "bellC", "bellF", "bellG", "clap"];
    rates = [2, 2, 2, 2];
    rawDistances = [0, 0, 0, 0];
    usbPorts = Array.fill(4, 0);
    ~rates = rates;

    "All USB Ports".postln;
    SerialPort.listDevices;
    "-----".postln;

    SerialPort.devicePattern = "/dev/tty.wchusbserial*";
    numSerialPorts = SerialPort.devices.size;

    avgBufferSize = 5;
    distanceValues = Array.fill(numSerialPorts, 0);
    distanceBusses = Array.fill(numSerialPorts, {Bus.control(s)});


    "INITIALIZING USB PORTS".postln;
    (0..(numSerialPorts-1)).do({ |index|
        var port, byte, str, setColor;
        ("This usb port: " ++ SerialPort.devices[index]).postln;

        port = SerialPort(
            SerialPort.devices[index],
            baudrate: 9600,
            crtscts: true);

        usbPorts.put(index, port);
    });

    ~printInd = 0;

    "STARTING USB READ/WRITE LOOP".postln;
    readValues = {
        inf.do{
            (0..(numSerialPorts-1)).do({ |index|
                var currentPort, byte, str, read, test;
                currentPort = usbPorts[index];
                read = false;


                while({read == false}, {
                    currentPort.putAll("1\n");
                    0.01.wait;
                    if(currentPort.next==10, {
                        var distValue;
                        str = "";
                        while({byte = currentPort.read; byte !=13 }, {
                            str= str++byte.asAscii;
                        });
                        if(index == 0, {
                        [~printInd, str].postln;
                        });

                        distValue = str.asFloat;
                        // ((index+1).asString ++ " :" ++ distValue.asString).postln;
                        rawDistances[index] = distValue;
                        if(distValue < 150, {
                            var zoneRate = (distValue/30.0).floor + 1;
                            rates[index] = zoneRate;
                        });
                        read = true;
                        0.05.wait;
                    });
                });
            });
        };
    };

    Routine.run(readValues);
    /*	{
    var serialRoutineFunc = {


    inf.do{
    if(port.read==10, {
    var distValue;
    str = "";
    while({byte = port.read; byte !=13 }, {
    str= str++byte.asAscii;
    });

    distValue = str.asFloat;
    // ((index+1).asString ++ " :" ++ distValue.asString).postln;
    rawDistances[index] = distValue;
    if(distValue < 150, {
    var zoneRate = (distValue/30.0).floor + 1;
    rates[index] = zoneRate;
    });
    });
    };
    };


    Routine.run(serialRoutineFunc);
    });*/

    "DEFINING SYNTHS".postln;
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
                Out.ar(i, PlayBuf.ar(1, trackBuffer, doneAction:2));
            }).send(s);

            s.sync;
        });
    };

    "STARING SYNTH PLAY LOOP".postln;
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


    "STARTING EASTER EGG SOUND LOOP".postln;
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

    ~rawDistances = rawDistances;
    ~arduinoLog = Task({
        {
            0.2.wait;
            ~rawDistances[0].postln;
        }.loop
    });

    ~arduinoLog.stop;



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
)


~rates
5.postln
0.range(0.05, 0.95)
