function key = convertToRoiMapKey(filename)
[~, stem, extension] = fileparts(filename);
key = [stem, '_av', extension];
end