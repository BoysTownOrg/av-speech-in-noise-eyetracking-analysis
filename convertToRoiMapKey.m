function key = convertToRoiMapKey(filename)
[~, stem, extension] = fileparts(filename);
if string(filename).contains('_av')
    stem = string(filename).extractBefore('_av').char;
end
key = [stem, '_av', extension];
end