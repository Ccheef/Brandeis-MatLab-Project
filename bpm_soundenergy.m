function output = bpm_soundenergy(track, Fs, downbeat)
    % Term Project: Musicpedia
    % Cosi177a. Scientific Process in Matlab
    % Team members: Boyuan(Jerry) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    % Date: May 2, 2017
    % This code implements the Sound Energy Beat Detection Algorithm, it
    % detects the number of beats (or downbeats) in a song
    % Format of Call: bpm_soundenergy(track, Fs, downbeat)
    % Returns a length-2 vector with number of beats and BPM

    % Trims the empty soundless parts of music on both sides so that
    % data would not be affected by the length of empty parts
    trimsleft = find(track(:, 1) ~= 0);  % find the points that have sound in left channel
    trimsright = find(track(:, 2) ~= 0); % find the points that have sound in right channel
    begrow = min(trimsleft(1), trimsright(1) - length(track)); % locate soundless section in beginning of music
    endrow = max(trimsleft(end), trimsright(end) - length(track)); % locate soundless section at end of music
    track(1:begrow-1, :) = []; % trim the soundless parts
    track(endrow+1:end, :) = [];

    track = track';
    %-------------------------------------------------------------------------%
    %Declare some universal variables / preallocate the memory space

    %Assigns 3000 sampled data per block
    sample_size = 3000;

    %The number of blocks for each second: frequency / sample_size(3000)
    blocks_per_sec = floor((Fs/sample_size));

    %Buffer of the block containing the data from the lastest block to read
    block_buffer = zeros(2,sample_size);

    %circular buffer containing the energy data from the lastest block to read
    %energy_buffer[1] contains the newest data of next block
    %energy_buffer[blocks_sec] contains the oldest data to be removed
    energy_buffer = zeros(1,blocks_per_sec);

    %constant value for linear regression on C, sensitivity detection
    m = -.0000000010;
    
    %if user asks for only downbeats (the first beat of a measure) , raise 
    %the sensitivity constant by 2 so that mostly only the downbeats
    %will be detected
    b = 1.88313142857;
    if downbeat
        b = b * 2;
    end

    %number of blocks that have been read
    block_count = 1;

    %total number of beats identified 
    beat_count = 0;

    %length of the music in seconds
    secs_of_song = length(track) / Fs;
    length_of_song = floor(secs_of_song);

    %the size of the track
    %calculate the number of data in the end of the song
    [~, samples] = size(track);
    missed_sample = samples - length_of_song*blocks_per_sec*3000;
    q = fix(missed_sample/sample_size);
    remainder = mod(missed_sample,sample_size);
    %*************************************************************************%

    %Calculate the energy in each window of blocks
    %Perform this operation for each instance of seconds
    for block_count= 1:length_of_song * blocks_per_sec+q %for each second and blocks
        block_buffer(1,:) = track(1,(block_count-1)*sample_size+1:block_count*sample_size); %extract the next sampled data from the original note
        block_buffer(2,:) = track(2,(block_count-1)*sample_size+1:block_count*sample_size);
        Ei = energy_per_block(block_buffer); %this gives the energy of the currect block
        avgE = mean(energy_buffer); %calculate the mean of the current energy buffer corresponding to one sec
        varE = var(energy_buffer); %calculate the variance of the current energy buffer corresponding to one sec
        energy_buffer = addEi(energy_buffer,Ei,blocks_per_sec); %renew the energy buffer
        C = m*varE + b; %calculate the sensitivity parameter
        if Ei > C*avgE
            beat_count = beat_count + 1;
        end
    end

    %Still have the last chunk of sampled data to determine if there is a beat
    %in the very end of the song
    %The algorithm is completely the same as before
    %Seperation of this very last case is to save one check process that has to
    %be done in the beginning of each iteration
    index = block_count * 3000;
    indexend = index + remainder;
    block_buffer = track(1,index:indexend)'; %extract the next sampled data from the original note
    block_buffer = [block_buffer track(2,index:indexend)'];
    Ei = energy_per_block(block_buffer); %this gives the energy of the currect block
    avgE = mean(energy_buffer); %calculate the mean of the current energy buffer corresponding to one sec
    varE = var(energy_buffer); %calculate the variance of the current energy buffer corresponding to one sec
    C = m*varE + b; %calculate the sensitivity parameter
    if Ei > C*avgE
        beat_count = beat_count + 1;
    end

    %Convert duration into minutes and calculate the bpm
    mins = secs_of_song / 60;
    bpm = beat_count / mins;

    %Returns the result
    output = [beat_count bpm];
end

    



