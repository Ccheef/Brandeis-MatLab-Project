function times = len2time(input, Fs)
    % Term Project: Musicpedia
    % Cosi177a. Scientific Process in Matlab
    % Team members: Jerry(Boyuan) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    % Date: May 2, 2017
    % This code converts the length of music data matrix into formatted
    % music length (x min x sec x ms)
    % Format of Call: len2time(input, Fs)
    % Returns a length-3 vector representing number of minutes, 
    % seconds, millsecs in a song

    % divides the length by frequency constant to get total number of
    % seconds in a song
    input = input / Fs;
    
    % preallocates the output vector
    times = zeros(1, 3);
    
    % if the song has enough minutes, turn each 60s into 1min, store
    % in index 1 of output matrix
    if input >= 60
        times(1) = floor(input/60);
        input = input - times(1) * 60;
    end
    
    % then, if the song has enough seconds (as integers), store the
    % number of seconds into index 2 of output matrix
    if input > 0
        times(2) = floor(input);
        input = input - times(2);
    end
    
    % then everything remained are decimals, turn these decimals
    % into millsecs by multiplying 1000, round and store the number 
    % into index 3 of output matrix
    if input > 0
        times(3) = round(input * 1000);
    end
end