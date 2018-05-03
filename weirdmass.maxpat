{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 7,
			"minor" : 3,
			"revision" : 5,
			"architecture" : "x86",
			"modernui" : 1
		}
,
		"rect" : [ 59.0, 104.0, 961.0, 643.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"boxes" : [ 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-23",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 189.0, 495.0, 50.0, 22.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-24",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 78.0, 564.0, 84.0, 22.0 ],
					"style" : "",
					"text" : "onepole~ 440"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-25",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 83.0, 539.0, 84.0, 22.0 ],
					"style" : "",
					"text" : "onepole~ 440"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-26",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 68.0, 515.0, 84.0, 22.0 ],
					"style" : "",
					"text" : "onepole~ 440"
				}

			}
, 			{
				"box" : 				{
					"attr" : "quality",
					"id" : "obj-27",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 189.0, 531.0, 150.0, 22.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-28",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 189.0, 459.0, 97.0, 22.0 ],
					"style" : "",
					"text" : "pitchshiftcent $1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-29",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 189.0, 426.0, 50.0, 22.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-30",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "list" ],
					"patching_rect" : [ 62.0, 470.0, 65.0, 22.0 ],
					"saved_object_attributes" : 					{
						"enabled" : [ 1 ],
						"pitchshift" : [ 10.0 ],
						"pitchshiftcent" : [ 3986 ],
						"quality" : "best",
						"reportlatency" : 0,
						"usecents" : 0
					}
,
					"style" : "",
					"text" : "pitchshift~"
				}

			}
, 			{
				"box" : 				{
					"format" : 6,
					"id" : "obj-22",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 583.0, 501.0, 50.0, 22.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-19",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 466.0, 576.0, 84.0, 22.0 ],
					"style" : "",
					"text" : "onepole~ 440"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 471.0, 551.0, 84.0, 22.0 ],
					"style" : "",
					"text" : "onepole~ 440"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-17",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 456.0, 527.0, 84.0, 22.0 ],
					"style" : "",
					"text" : "onepole~ 440"
				}

			}
, 			{
				"box" : 				{
					"attr" : "usecents",
					"id" : "obj-16",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 583.0, 539.0, 150.0, 22.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-15",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 583.0, 470.0, 97.0, 22.0 ],
					"style" : "",
					"text" : "pitchshiftcent $1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 583.0, 432.0, 50.0, 22.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "list" ],
					"patching_rect" : [ 450.0, 482.0, 65.0, 22.0 ],
					"saved_object_attributes" : 					{
						"enabled" : [ 1 ],
						"pitchshift" : [ 10.0 ],
						"pitchshiftcent" : [ 3986 ],
						"quality" : "best",
						"reportlatency" : 0,
						"usecents" : 0
					}
,
					"style" : "",
					"text" : "pitchshift~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 361.0, 576.0, 45.0, 45.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"clipheight" : 60.0,
					"data" : 					{
						"clips" : [ 							{
								"filename" : "/Users/avneeshsarwate/Downloads/tubular_bells/Sederunt_Principes_Perotin.wav",
								"filekind" : "audiofile",
								"loop" : 0,
								"content_state" : 								{
									"originallength" : [ 0.0, "ticks" ],
									"basictuning" : [ 440 ],
									"formant" : [ 1.0 ],
									"timestretch" : [ 0 ],
									"originallengthms" : [ 0.0 ],
									"followglobaltempo" : [ 0 ],
									"play" : [ 0 ],
									"slurtime" : [ 0.0 ],
									"quality" : [ "basic" ],
									"formantcorrection" : [ 0 ],
									"speed" : [ 1.0 ],
									"mode" : [ "basic" ],
									"originaltempo" : [ 120.0 ],
									"pitchshift" : [ 1.0 ],
									"pitchcorrection" : [ 0 ]
								}

							}
 ]
					}
,
					"id" : "obj-5",
					"maxclass" : "playlist~",
					"numinlets" : 1,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
					"patching_rect" : [ 88.0, 309.0, 796.0, 61.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"clipheight" : 60.0,
					"data" : 					{
						"clips" : [ 							{
								"filename" : "/Users/avneeshsarwate/Downloads/tubular_bells/Sederunt_Principes_Perotin.wav",
								"filekind" : "audiofile",
								"loop" : 0,
								"content_state" : 								{
									"originallength" : [ 0.0, "ticks" ],
									"basictuning" : [ 440 ],
									"formant" : [ 1.0 ],
									"timestretch" : [ 0 ],
									"originallengthms" : [ 0.0 ],
									"followglobaltempo" : [ 0 ],
									"play" : [ 0 ],
									"slurtime" : [ 0.0 ],
									"quality" : [ "basic" ],
									"formantcorrection" : [ 0 ],
									"speed" : [ 1.0 ],
									"mode" : [ "basic" ],
									"originaltempo" : [ 120.0 ],
									"pitchshift" : [ 1.0 ],
									"pitchcorrection" : [ 0 ]
								}

							}
 ]
					}
,
					"id" : "obj-4",
					"maxclass" : "playlist~",
					"numinlets" : 1,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
					"patching_rect" : [ 88.0, 226.0, 796.0, 61.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"clipheight" : 60.0,
					"data" : 					{
						"clips" : [ 							{
								"filename" : "/Users/avneeshsarwate/Downloads/tubular_bells/Sederunt_Principes_Perotin.wav",
								"filekind" : "audiofile",
								"selection" : [ 0.521333, 0.642667 ],
								"loop" : 1,
								"content_state" : 								{
									"originallength" : [ 0.0, "ticks" ],
									"basictuning" : [ 440 ],
									"formant" : [ 1.0 ],
									"timestretch" : [ 0 ],
									"originallengthms" : [ 0.0 ],
									"followglobaltempo" : [ 0 ],
									"play" : [ 0 ],
									"slurtime" : [ 0.0 ],
									"quality" : [ "basic" ],
									"formantcorrection" : [ 0 ],
									"speed" : [ 1.0 ],
									"mode" : [ "basic" ],
									"originaltempo" : [ 120.0 ],
									"pitchshift" : [ 1.0 ],
									"pitchcorrection" : [ 0 ]
								}

							}
 ]
					}
,
					"id" : "obj-3",
					"maxclass" : "playlist~",
					"numinlets" : 1,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
					"patching_rect" : [ 88.0, 149.0, 796.0, 61.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"clipheight" : 60.0,
					"data" : 					{
						"clips" : [ 							{
								"filename" : "/Users/avneeshsarwate/Downloads/tubular_bells/Sederunt_Principes_Perotin.wav",
								"filekind" : "audiofile",
								"selection" : [ 0.073333, 0.132 ],
								"loop" : 1,
								"content_state" : 								{
									"originallength" : [ 0.0, "ticks" ],
									"basictuning" : [ 440 ],
									"formant" : [ 1.0 ],
									"timestretch" : [ 0 ],
									"originallengthms" : [ 0.0 ],
									"followglobaltempo" : [ 0 ],
									"play" : [ 0 ],
									"slurtime" : [ 0.0 ],
									"quality" : [ "basic" ],
									"formantcorrection" : [ 0 ],
									"speed" : [ 1.0 ],
									"mode" : [ "basic" ],
									"originaltempo" : [ 120.0 ],
									"pitchshift" : [ 1.0 ],
									"pitchcorrection" : [ 0 ]
								}

							}
 ]
					}
,
					"id" : "obj-2",
					"maxclass" : "playlist~",
					"numinlets" : 1,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
					"patching_rect" : [ 88.0, 76.0, 796.0, 61.0 ],
					"style" : ""
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"source" : [ "obj-17", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-19", 0 ],
					"source" : [ "obj-18", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 1 ],
					"source" : [ "obj-19", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 1 ],
					"order" : 2,
					"source" : [ "obj-22", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 1 ],
					"order" : 0,
					"source" : [ "obj-22", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-19", 1 ],
					"order" : 1,
					"source" : [ "obj-22", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 1 ],
					"order" : 1,
					"source" : [ "obj-23", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-25", 1 ],
					"order" : 0,
					"source" : [ "obj-23", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-26", 1 ],
					"order" : 2,
					"source" : [ "obj-23", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"source" : [ "obj-24", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"source" : [ "obj-25", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-25", 0 ],
					"source" : [ "obj-26", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"source" : [ "obj-27", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"source" : [ "obj-28", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-28", 0 ],
					"source" : [ "obj-29", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-26", 0 ],
					"source" : [ "obj-30", 0 ]
				}

			}
 ],
		"dependency_cache" : [ 			{
				"name" : "Sederunt_Principes_Perotin.wav",
				"bootpath" : "~/Downloads/tubular_bells",
				"patcherrelativepath" : "../Downloads/tubular_bells",
				"type" : "WAVE",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
