function map = convertToRoiMap(matFileContents, videoPixels)
map = containers.Map();
for i = 1:numel(matFileContents)
    fileInfo = matFileContents{i};
    map(fileInfo.file) = aspl.videoRelativeNormalizedRegionFace(fileInfo, videoPixels);
end
end