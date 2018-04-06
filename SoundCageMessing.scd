(
var trackBuffer, synth, length, files, file, rates, newLength, iChanging, special, specialRate;
special = false;
files = ["bellA", "bellC", "bellF", "bellG", "clap"];
rates = [2, 2, 2, 2];

Routine.run {
	s.bootSync;

	for(0, 4, {
		arg i;
		file = files[i];
		trackBuffer = Buffer.read(s, "/Users/rytrose/Desktop/" ++ file ++ ".wav", action: {
			length = (trackBuffer.numFrames / trackBuffer.numChannels) / trackBuffer.sampleRate;
			[file, length].postln;
		});

		SynthDef.new(file, {
			Out.ar([0,1], PlayBuf.ar(2, trackBuffer));
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
		rates[iChanging] = [1,1,1,1];
		rates.postln;
		4.wait;
	}.loop
}

)

(
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
//Avneesh push test
~hitNote = 3.;