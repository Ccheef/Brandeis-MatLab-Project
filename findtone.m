function output = findtone(input)
    % Term Project: Musicpedia
    % Cosi177a. Scientific Process in Matlab
    % Team members: Boyuan(Jerry) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    % Date: May 2, 2017
    % This code finds the tone(note) according to the frequency that already
    % represents a pitch (found by findpitch function)
    % Format of Call: findtone(input)
    % Returns the a numerical value representing tone(note) in the order
    % of half scales (ie 1 = C, 2 = C#, 3 = D etc.)
    
    % Since no functional relationship (ie linear, although each two values
    % have a ratio of about 1:2) between notes, still need to construct
    % the lists manually
    
    % if the frequency represents one of the C's (C1 - ... - C7), outputs
    % 1 = C
    if any([32.70 65.41 130.81 261.63 523.25 1046.5 2093] == input)
        output = 1;
    % if the frequency represents one of the C#'s (C#1 - ... - C#7), outputs
    % 2 = C#
    elseif any([34.65 69.3 138.59 277.18 554.37 1108.73 2217.46] == input)
        output = 2;       
    % if the frequency represents one of the D's (D1 - ... - D7), outputs
    % 3 = D        
    elseif any([36.71 73.42 146.83 293.66 587.33 1174.66 2349.32] == input)      
        output = 3;
    % if the frequency represents one of the D#'s (D#1 - ... - D#7), outputs
    % 4 = D#          
    elseif any([38.89 77.78 155.56 311.13 622.25 1244.51 2489.02] == input)
        output = 4;
    % if the frequency represents one of the E's (E1 - ... - E7), outputs
    % 5 = E         
    elseif any([41.2 82.41 164.81 329.63 659.25 1318.51 2637.02] == input)
        output = 5;
    elseif any([43.65 87.31 174.61 349.23 698.46 1396.91 2793.83] == input)
    % if the frequency represents one of the F's (F1 - ... - F7), outputs
    % 6 = F         
        output = 6;
    % if the frequency represents one of the F#'s (F#1 - ... - F#7), outputs
    % 7 = F#  
    elseif any([46.25 92.5 185 369.99 739.99 1479.98 2959.96] == input)
        output = 7;
    % if the frequency represents one of the G's (G1 - ... - G7), outputs
    % 8 = G 
    elseif any([49 98 196 392 783.99 1567.98 3135.96] == input)
        output = 8;
    % if the frequency represents one of the G's (G#1 - ... - G#7), outputs
    % 9 = G#
    elseif any([51.91 103.83 207.76 415.3 830.61 1661.22 3322.44] == input)
        output = 9;
    % if the frequency represents one of the A's (A1 - ... - A7), outputs
    % 10 = A
    elseif any([55 110 220 440 880 1760 3520] == input)
        output = 10;
    % if the frequency represents one of the A#'s (A#1 - ... - A#7), outputs
    % 11 = A#        
    elseif any([58.27 116.54 233.08 466.16 932.22 1864.66 3729.31] == input)
        output = 11;
    % if the frequency represents one of the B's (B1 - ... - B7), outputs
    % 12 = B 
    elseif any([61.74 123.47 246.94 493.88 987.77 1975.53 3951.07] == input)
        output = 12;
    % otherwise return -1 (in case of error, but usually doesn't happen)
    else
        output = -1;
    end
end