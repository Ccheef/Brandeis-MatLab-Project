function data = findpoints(input, value, Fs)
    % Term Project: Musicpedia
    % Cosi177a. Scientific Process in Matlab
    % Team members: Jerry(Boyuan) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
    % Date: May 2, 2017
    % This code finds the detailed distribution of specific music strength
    % points in a song
    % Format of Call: pointlist(input, value, Fs)
    % Returns a vector representing all points(indices) of specific music strength
    % in a song
    
    % find the indices which reach specific music strength
    pointlist = (find(input == value))';
    
    % if the indices are in right channel (larger than half of the total
    % numel of the input matrix), generalize the indices into range of
    % [1, length(input)] by subtracting length(input) (for convenience
    % ie when applying the len2time function)
    rightinds = find(pointlist > length(input));
    pointlist(rightinds) = pointlist(rightinds) - length(input);
    
    % eliminate the duplicate points - since usually the sample rate is
    % rather huge (ie 44100), there are different indices that actually
    % pointing to the same time point that need to be removed
    i = 1;
    if length(pointlist) > 1
        while  i <= length(pointlist)
            % remove duplicates
            while isequal(len2time(pointlist(i), Fs),len2time(pointlist(i+1), Fs))
                pointlist(i+1) = [];
                % in case duplicates appear in the end so that it already
                % reaches the end, need to jump out immediately
                if i == length(pointlist)
                    break
                end
            end
            i = i + 1;
            % if reaches the end, jump out ouf loop immediately
            if i == length(pointlist)
                break
            end
        end
    end
    
    % output
    data = pointlist;
end