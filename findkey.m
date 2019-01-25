function output = findkey(track, Fs)
    % Term Project: Musicpedia
    % Cosi177a. Scientific Process in Matlab
    % Team members: Boyuan(Jerry) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    % Date: May 2, 2017
    % This code finds the possible key signature according to a music track
    % (It is also the main function for the key signature part)
    % Format of Call: findkey(track, Fs)
    % Returns a length-6 vector representing all six possible answers
    % for the key signature of the song
    
    % Trim the beginning and end soundless part of the song - that is, find
    % "the first zero" before the first non-zero music strength value;
    % find "the last zero" after the last non-zero music strength value
    trims = find(track ~= 0);
    if track(1) ~= 0
        firstzero = 0;
    else
        firstzero = trims(1) - 1;
    end
    lastzero = trims(end) + 1;

    % Find the zero values in the middle of the song, which helps us
    % locate all the waves in the song (because each wave surpasses
    % the zero point in the middle) and combine them with the first zero
    % and the last zero (beginning and end points)
    middlezeroes = find(track(trims(1):trims(end)) == 0);
    middlezeroes = middlezeroes';
    zeroes = [firstzero middlezeroes lastzero];
    
    % Find the differences between the zeroes. If the difference is too
    % small, which represents soundless part or very soft part in a song, 
    % need to filter them, otherwise will be very costly in the execution
    % because we will need to calculate the soundless spots 1 by 1
    freqs = diff(zeroes);
    freqs = freqs(freqs >= 10);
    
    % Divide them by the sample rate - now the units we have are seconds
    % which are still not really frequencies
    freqs = freqs ./ Fs;

    % We sum the differences 2 by 2 because the sum of each 2 value
    % really represents the period of a whole wave (1 value represents
    % only a half wave)
    timeofsums = floor(length(freqs) / 2);
    for i = 1:timeofsums
        freqs(i) = freqs(i)+ freqs(i+1);
        freqs(i+1) = [];
    end

    % Now we find the reciprocals and we really have the frequencies
    freqs = 1./freqs;
    
    % Now we have real frequencies. So we can filter the frequencies
    % to make it doesn't go below f(C1) = 32.7 or beyond f(B7) = 3951.07 
    % - because normally music pitch in a song doesn't go too high or too low
    freqs = freqs(freqs<= 3951.07 & freqs >= 32.70);
    
    % For each of frequency, find its corresponding tone by:
    % 1. first call findpitch function to match it to certain pitch
    % 2. then with the pitch, call findtone function to find the tone
    % that it belongs to (because here requires comparison one by one 
    % value, use for loop instead of vectorization)
    for i = 1:length(freqs)
        freqs(i) = findtone(findpitch(freqs(i))); 
    end

    % Find the tone(note) appear most frequently in the song, call
    % tone2key function to convert it to a set of possible key
    % signatures and output it
    output = tone2key(mode(freqs));
end