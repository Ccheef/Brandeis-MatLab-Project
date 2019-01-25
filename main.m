% Term Project: Musicpedia
% Cosi177a. Scientific Process in Matlab
% Team members: Boyuan(Jerry) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
% Date: May 2, 2017
% Welcome to Musicpedia! This is the main function that interacts with the 
% user. The user should open main.m to input music, then it will output 
% various properties of the music including the music length, average,
% variance of music strength, minimum/maximum music strength value as well
% as distribution of such points, the number of beats, BPM (beats per
% minute), possible meter type, main tone, possible key signature and show
% the plots of music strength distribution by left/right channel
% respectively.

% Prompts the user for the input of music file
filename = input('Music Name Input: ', 's');

% Gets the general sampled data of music strength in the song
% using the audioread built-in function
[track,Fs] = audioread(filename);

% Call len2time function to find the length of music in format of 
% X min X sec X ms according to the length of sampled track
tracklength = len2time(length(track), Fs);
fprintf('\n')
fprintf('Time Length: %d min %d sec %d ms\n', tracklength(1), tracklength(2), tracklength(3))

% Call miscinfo function to find the miscellaneous information about 
% the music, including the average, variance, minimum/maximum of 
% music strength
info = miscinfo(track);

% Outputs average and variance
% Since the average of music strength is usually rather small, we weight
% it by multiplying 1,000
fprintf('Weighted Average Strength: %.4f\n', info(1) * 1000)
fprintf('Variance of Strength: %.4f\n', info(2))

% Outputs value of maximum strength, which stores in index 3 of info vector
fprintf('Max Strength: %.2f\n', info(3))

% Call findpoints function to find the detailed distribution of points
% at maximum strength in the music
maxinfo = findpoints(track, info(3), Fs);

% Prints out these points, if there are more than 10 points, just show
% the first 10 and say "there are x more points" (x representing the
% difference between total number and 10)
fprintf('\tPoints:\n')
for i = 1:min(length(maxinfo), 10)
    current = len2time(maxinfo(i), Fs);
    fprintf('\t%d min %d sec %d ms', current(1), current(2), current(3))
end
fprintf('\n')
if length(maxinfo) > 10
	fprintf('\tand %d more points\n', length(maxinfo) - 10)
end

% Outputs value of minimum strength, which stores in index 4 of info vector
fprintf('Min Strength: %.2f\n', info(4))

% Call findpoints function again to find the detailed distribution of points
% at minimum strength in the music
mininfo = findpoints(track, info(4), Fs);

% Prints out these points, if there are more than 10 points, just show
% the first 10 and say "there are x more points" (x representing the
% difference between total number and 10)
fprintf('\tPoints:\n')
for i = 1:min(length(mininfo), 10)
    current = len2time(mininfo(i), Fs);
    fprintf('\t%d min %d sec %d ms', current(1), current(2), current(3))
end
fprintf('\n')
if length(mininfo) > 10
	fprintf('\tand %d more points\n', length(mininfo) - 10)
end

% Call bpm_soundenergy function to calculate the number of regular beats
% in the song (because we are looking for *regular beats*, the 3rd arg
% is false - for detail refer to intro in bpm_soundenergy function)
% Also, the BPM (use the length of effective
% time - because soundless parts at beginning and end are trimmed away
% to divide the number of regular beats) stores in index 2
beatinfo = bpm_soundenergy(track, Fs, false);


% Call bpm_soundenergy function to calculate the number of down beats
% (the first beats of each measure) in the song (because we are looking 
% for only *down beats*, the 3rd arg is true - for detail refer to intro 
% in bpm_soundenergy function)
downinfo = bpm_soundenergy(track, Fs, true);

% Print out the number of (regular) beats, BPM. Calls findmeter function
% to find and output the meter type of music according to the ratio between 
% number of downbeats and regular beats
fprintf('Number of Beats: %d\n', beatinfo(1))
fprintf('Beats Per Minute: %.2f\n', beatinfo(2))
fprintf('Possible Meter: %s\n', findmeter(downinfo(1), beatinfo(1)))

% Call findkey function to find the possible key of the music (since
% usually a single track is typical enough to reflect the whole melody
% distribution of the music, here we just use track(:, 1) - the left track)
keyinfo = findkey(track(:, 1), Fs);

% Outputs the main tone, which is the tone/note appears most frequently
% in a song, represented by index 1 of the keyinfo array
fprintf('Main Tone: %s\n', keyinfo{1})

% Outputs the six possible key signatures (possible key group) of the song
% according to the main tone
fprintf('Possible Key Signatures: ')
for i = 1:6
    fprintf('%s   ', keyinfo{i})
end
fprintf('\n\n')
fprintf('The Plots of the Song is shown afterwards\n')

% Plots the music by its left and right channels respectively, show the
% two figures
figure
plot(1:length(track), track(:, 1));
title('Left Channel')
figure
plot(1:length(track), track(:, 2));
title('Right Channel')