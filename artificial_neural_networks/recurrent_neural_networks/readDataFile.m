function X_data = readDataFile(filename)
  
  fid = fopen(filename,'r');
  if fid
    X_data = fscanf(fid, '%c', inf);
    fclose(fid);
  else
    X_data = '';
    fprintf('Unable to open %s\n', filename);
  endif
  
end