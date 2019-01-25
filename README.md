Project Name: Musicpedia
Team Members: Siyuan Lu, Qifu Yin, Boyuan Sun
Date: May 2, 2017

1. Introduction
Welcome to Musicpedia! This program constructs the encyclopedia for musics.
It takes a song as input and print out the details of its various musical 
features. The musical features we deal with in this program including: 
music length, average of music strength, variance of music strength, 
minimum/maximum music strength value, distribution of min/max points, 
the number of beats, BPM (beats per minute), possible meter type, 
main tone, possible key signature. It will also show the plots of 
music strength distribution by its left/right channel respectively.
You can either execute main.m to run the main program or try out
our user interface by executing gui.m (for details, see 2. Way of Execution)

2. Way of Execution
(1) Main Program
	A. Open the Codes Folder -> main.m and run the program in Matlab
	B. Type in the name of a song - i.e. ppap.mp3
		BEWARE:
		I. Besure the song is in the SAME folder as the program!
		II. DO NOT forget the postfix! (i.e. .mp3, .wav)
	C. Press ENTER, then everything about the music will pop out,
	including the two plots of music distribution, ENJOY!

(2) Graphic User Interface (GUI)
	A. Open the Codes Folder -> gui.m and run the program in Matlab
	B. Type into the cursor (blank area) the name of a song - i.e. nobody.mp3
		BEWARE:
		I. Besure the song is in the SAME folder as the program!
		II. DO NOT forget the postfix! (i.e. .mp3, .wav)
	C. Click on the “run” button, then everything about the music will
	display, including the two plots of music distribution, ENJOY!

3. Structure of program and miscellaneous
A. Main functions/Interfaces
main.m
gui.m (supported by gui.fig)

B. Supporting Functions
len2time.m: 
	for music length

addEi.m
bpm_soundenergy.m
eneger_per_block.m:
	for number of beats and BPM

miscinfo.m:
	for average and variance of music strength
	for value of minimum, maximum point

findpoints.m:
	for specific distribution of minimum, maximum points

findmeter.m:
	for meter type

findkey.m
findpitch.m
findtone.m
tone2key.m:
	for main tone and key signature

4. Other Notices
(1) The GUI runs slightly different from the main program in the min/max points
part that main program prints out the locations of first ten points and the 
number of the rest of points, while GUI shows just the total number of points.

(2) Currently the key signature part works better with musics with simple melodies
(i.e. piano songs). It’s normal if the result differs by a half step from the
actual key when it comes to a song that has complicated melodies (i.e. piano, 
percussions, violin… everything together) or a song produced many years ago
