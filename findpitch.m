function output = findpitch(x)
    % Term Project: Musicpedia
    % Cosi177a. Scientific Process in Matlab
    % Team members: Boyuan(Jerry) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    % Date: May 2, 2017
    % This code matches a frequency value to the closest pitch of song
    % Format of Call: findpitch(x)
    % Returns the frequency corresponding to a certain pitch
    
    % initialization
    upper = -1;
    lower = -1;
    
    % because there's no functional (ie linear) relationship between
    % pitches, we can only construct the "dictionary" of pitches manually
    % using the data from the frequency vs. note chart on the
    % referenced music website
    
    % oct1 - oct7 representing octave 1 - octave 7, then concatenate them
    oct1 = [32.70 34.65 36.71 38.89 41.2 43.65 46.25 49 51.91 55 58.27 61.74];
    oct2 = [65.41 69.3 73.42 77.78 82.41 87.31 92.5 98 103.83 110 116.54 123.47];
    oct3 = [130.81 138.59 146.83 155.56 164.81 174.61 185 196 207.76 220 233.08 246.94];
    oct4 = [261.63 277.18 293.66 311.13 329.63 349.23 369.99 392 415.3 440 466.16 493.88];
    oct5 = [523.25 554.37 587.33 622.25 659.25 698.46 739.99 783.99 830.61 880 932.22 987.77];
    oct6 = [1046.5 1108.73 1174.66 1244.51 1318.51 1396.91 1479.98 1567.98 1661.22 1760 1864.66 1975.53];
    oct7 = [2093 2217.46 2349.32 2489.02 2637.02 2793.83 2959.96 3135.96 3322.44 3520 3729.31 3951.07];
    oct = [oct1 oct2 oct3 oct4 oct5 oct6 oct7];
    
    % find out which range that the frequency belongs to
    for i = 1:length(oct)-1
        if x >= oct(i) && x < oct(i+1)
            upper = oct(i+1);
            lower = oct(i);
            break
        end
    end
    
    % then in the specific range, find if the frequency is closer to
    % the upper bound or the lower bound, if closer to upper bound,
    % outputs the value of upper bound (the frequency of the upper bound
    % pitch), otherwise, output that of the lower bound
    if upper - x >= x - lower
        output = lower;
    else
        output = upper;
    end
end 