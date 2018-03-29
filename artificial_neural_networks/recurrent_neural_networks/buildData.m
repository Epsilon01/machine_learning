function X = buildData(data_filename, nb_words)
  
  text = readDataFile(data_filename);
  
  % Extract sentences
  sentences = regexp(text,'\S.*?[\.\!\?]','match');
  save("-binary", "sentences.mat", "sentences");
  
%  % Extract words
%  words = strsplit(text)';
%  
%  %  Count words
%  [words_u, ~, idxU] = unique(words);
%  counts = accumarray(idxU, 1);
%
%  % Sort entries by count
%  [~, idxS] = sort(counts, 'descend');
%  words_us = words_u(idxS);
%  counts_s = counts(idxS);
%
%  % Build cell array of unique words and counts.
%  result = [words_us, num2cell(counts_s)];
%  result = result(1:nb_words,:);
%  save dico result;
  
end