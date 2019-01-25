function output = tone2key(input)
    % Term Project: Musicpedia
    % Cosi177a. Scientific Process in Matlab
    % Team members: Boyuan(Jerry) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    % Date: May 2, 2017
    % This code finds the eventual answer of possible key signatures 
    % according to a tone represented by a numerical value (1-12)
    % Format of Call: tone2key(input)
    % Returns the a cell array representing all 6 possible answers of
    % key signature (there's the key of the tone itself, its relative
    % major/minor, parallel major/minor, fifth scale major/minor etc.
    % altogether 6 possible answers)
    
    % Use a switch condition to generate the corresponding answers
    % (C = 1, C# = 2, D = 3, D# = 4, E = 5, ...)
    switch input
        case 1
            output = {'C', 'c', 'a', 'E flat', 'g', 'B flat'};
        case 2
            output = {'C sharp', 'c sharp', 'b flat', 'E', 'f sharp', 'A'};
        case 3
            output = {'D', 'd', 'b', 'F', 'g', 'B flat'};
        case 4
            output = {'E flat', 'e flat', 'c', 'G flat', 'g sharp', 'B'};
        case 5
            output = {'E', 'e', 'c sharp', 'G', 'a', 'C'};
        case 6
            output = {'F', 'f', 'd', 'A flat', 'b flat','D flat'};
        case 7
            output = {'F sharp', 'f sharp', 'd sharp', 'A', 'b', 'D'};
        case 8
            output = {'G', 'g', 'e', 'B flat', 'c', 'E flat'};
        case 9
            output = {'A flat', 'g sharp', 'f', 'B', 'c sharp', 'E'};
        case 10
            output = {'A', 'a', 'f sharp', 'C', 'd', 'F'};    
        case 11
            output = {'B flat', 'b flat', 'g', 'D flat', 'd sharp', 'F sharp'};    
        case 12
            output = {'B', 'b', 'g sharp', 'D', 'e', 'G'};
        otherwise
            output = 'hard to know';
    end
 end