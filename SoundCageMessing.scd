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
    var trackBuffer, length, files, file, rates, newLength, iChanging, special, specialRate, avgBufferSize, distanceValues, colorStates, numSerialPorts, distanceBusses, rawDistances, usbPorts;
    var readValues, clock, lastTouchTime, controlBusses, playingPerotin, synths;

    special = false;
    files = ["bellA", "bellC", "bellF", "bellG", "perotin1"];
    rates = [2, 2, 2, 2];
    rawDistances = [0, 0, 0, 0];
    usbPorts = Array.fill(4, 0);
    lastTouchTime = [0, 0, 0, 0];
    ~lastTouchTime = lastTouchTime;
    controlBusses = Array.fill(files.size, {Bus.control(s, 1)});
    playingPerotin = Array.fill(4, {0});
    synths = Array.fill(4, {nil});

    clock = TempoClock.new(5);
    ~clock = clock;
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

    ~printDist = true;
    ~distlog = [nil, nil, nil, nil];

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
                        // distLog.add(str);

                        distValue = str.asFloat;
                        // ((index+1).asString ++ " :" ++ distValue.asString).postln;
                        rawDistances[index] = distValue;
                        if(distValue < 150, {
                            var zoneRate = ((distValue/30.0).floor + 1) * 2;
                            ~distlog[index] = zoneRate;
                            controlBusses[index].set(1);
                            rates[index] = zoneRate;
                            lastTouchTime[index] = clock.beats;
                        });
                        read = true;
                        0.001.wait;
                    });
                });
            });
            (0..(numSerialPorts-1)).do({|i|
                if((rates[i]==2) && (rates[(i-1)%numSerialPorts] == 8), {
                    if(playingPerotin[i] == 0, {
                        ["PEROTIN ON DECK", i].postln;
                        playingPerotin[i] = 1;
                        clock.sched(10*clock.tempo, {playingPerotin[i] = 0; ["PEROTIN ENDED", i].postln;});
                    });
                });
            });
            if(~printDist, {~distlog.postln});
        };
    };

    Routine.run(readValues);


    "DEFINING SYNTHS".postln;
    Routine.run {
        s.bootSync;

        (0..files.size).do({|i| controlBusses[i].set(1)});

        s.sync;

        for(0, files.size-2, {
            arg i;
            file = files[i];
            trackBuffer = Buffer.readChannel(s, fileDir ++ file ++ ".wav", action: {
                length = (trackBuffer.numFrames / trackBuffer.numChannels) / trackBuffer.sampleRate;
                [file, length].postln;
            }, channels:[0]);

            s.sync;

            SynthDef.new(file, {
                var freq = 1500;
                Out.ar(i, LPF.ar(LPF.ar(PlayBuf.ar(1, trackBuffer, doneAction:2), freq), freq) * In.kr(controlBusses[i]) );
            }).send(s);

            s.sync;

            trackBuffer = Buffer.readChannel(s, fileDir ++ files.last ++ ".wav", action: {
                length = (trackBuffer.numFrames / trackBuffer.numChannels) / trackBuffer.sampleRate;
                [fileDir ++ files.last ++ ".wav", length].postln;
            }, channels:[0]);
            s.sync;

            SynthDef.new(files.last++i, {
                var freq = 1500;
                Out.ar(i, LPF.ar(LPF.ar(PlayBuf.ar(1, trackBuffer, doneAction:2), freq), freq));
            }).send(s);

            s.sync
        });

        s.sync;

        "STARING SYNTH PLAY LOOP".postln;

        ~decayTime = 2; //seconds
        ~preDecayBuffer = 1; //seconds

        ~bellLog = false;
        for(0, files.size-2, {
            arg i;
            var task = Task.new({
                {
                    if((clock.beats.floor % rates[i]) == 0, {
                        var soundingWindow = (~decayTime + ~preDecayBuffer) * clock.tempo;
                        if(((clock.beats - lastTouchTime[i]) < soundingWindow) && (playingPerotin[i] == 0), {
                            synths[i] = Synth.new(files[i]);
                        });
                        if(playingPerotin[i] == 1, {
                            playingPerotin[i] = 2;
                            /*synths[i].free;
                            s.sync;*/
                            synths[i] = Synth.new(files.last++i);
                            ["PEROTIN PLAYED", i].postln;
                        });
                    });
                    1.wait;
                    if(~bellLog, {["playing bell", i, rates[i]].postln});
                }.loop
            }, clock);
            task.play;
        });



        Task({
            {
                (0..files.size-2).do({|i|
                    var noTouchTime = clock.beats - lastTouchTime[i];
                    if(noTouchTime > (~preDecayBuffer * clock.tempo), {
                        var decayOffset = noTouchTime - (~preDecayBuffer * clock.tempo);
                        var decayTime_beats = (~decayTime * clock.tempo);
                        var decayFraction = max((decayTime_beats - decayOffset) / decayTime_beats, 0);
                        controlBusses[i].set(decayFraction);
                    });
                });
                0.1.wait;
            }.loop;
        }).play;


        /*"STARTING EASTER EGG SOUND LOOP".postln;
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
        };*/

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
max(0, 6)
-1%4
for(0, 5, {arg i; i.postln})
(0..5)
(
~rates[0] = 10;
~rates[1] = 5;
~rates[2] = 7;
~rates[3] = 10;

)

~rates
5.postln
0.range(0.05, 0.95)
