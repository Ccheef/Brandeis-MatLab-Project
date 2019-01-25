function output = findmeter(downbeats, beats)
    % Term Project: Musicpedia
    % Cosi177a. Scientific Process in Matlab
    % Team members: Jerry(Boyuan) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    % Date: May 2, 2017
    % This code determines the meter of a song by the ratio between
    % number of its downbeats and regular beats
    % Format of Call: findmeter(downbeats, beats)
    % Returns a string representing the type of meter
    
    % find the ratio between downbeats and regular beats
    ratio = beats / downbeats;
    
    % generalizes the ratio into a smaller number (4.5) to generalize
    % cases (ie meters of 2/4 and 8/16 are actually same cases)
    while ratio >= 4.5
        ratio = ratio / 2;
    end
    
    % if the ratio is closer to 2, it is duple meter (2/4)
    if ratio > 1.5 && ratio <= 2.5
        output = 'duple meter';
        
    % if the ratio is closer to 3, it is triple meter (3/4)
    elseif ratio > 2.5 && ratio <= 3.5
        output = 'triple meter (waltz)';
        
    % if the ratio is closer to 4, it is quadruple meter (4/4)
    elseif ratio > 3.5 && ratio <= 4.5
        output = 'quadruple meter';
    
    % otherwise hard to identify the meter type
    else
        output = 'hard to tell';
    end
end