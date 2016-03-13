function [ probRanks,list] = predict_XQDA( W,M,galFea,probFea,galLabels,probLabels)
%PREDICT_XQDA Summary of this function goes here
%   Detailed explanation goes here
     if ~(size(galFea,1)==size(probFea,1) && size(galFea,2)==size(probFea,2))
         display('wrong data input');
     end 
     dist=MahDist(M, galFea * W,probFea * W); 
      score=-dist;
     if ~iscolumn(galLabels)
        galLabels = galLabels';
    end

    if ~isrow(probLabels)
        probLabels = probLabels';
    end
    
    binaryLabels = bsxfun(@eq, galLabels, probLabels); % match / non-match labels corresponding to the score matrix
    
    if any( all(binaryLabels == false, 1) ); % check whether all probe samples belong to the gallery
        error('This is not a closed-set identification experiment.');
    end
    

    %% get the matching rank of each probe
    [~, sortedIndex] = sort(score, 'descend'); % rank the score
   % [~, sortedIndex] = sort(score, 2); % rank the score
    score(binaryLabels == false) = -Inf; % set scores of non-matches to -Inf
    clear binaryLabels
    [~, maxIndex] = max(score); % get the location of the maximum genuine score
    [probRanks, ~] = find( bsxfun(@eq, sortedIndex, maxIndex) ); % get the matching rank of each probe, by finding the location of the matches in the sorted index
    clear  maxIndex
    list=sortedIndex';
    
    %% evaluate
    if ~iscolumn(probRanks)
        probRanks = probRanks';
    end

end

