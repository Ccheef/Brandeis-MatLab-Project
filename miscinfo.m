function data = miscinfo(input)
    % Term Project: Musicpedia
    % Cosi177a. Scientific Process in Matlab
    % Team members: Jerry(Boyuan) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    % Date: May 2, 2017
    % This code finds the miscellaneous data of a song including the
    % average/variance/max/min of music strength.
    % Format of Call: miscinfo(input)
    % Returns a length-4 vector representing average, residual, max/min
    % of music strength
    
    % preallocates the output vector
    data = zeros(1, 4);
    
    % store each answer, 1 for average, 2 for variance, 3/4 for max/min
    data(1) = mean(mean(input));
    data(2) = var(input(:));    % since there are 2 columns, apply the (:) expression
    data(3) = max(max(input));
    data(4) = min(min(input));
end