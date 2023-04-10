function map = convertToRoiMap(matFileContents, videoPixels)
map = containers.Map();
for i = 1:numel(matFileContents)
    fileInfo = matFileContents{i};
    roi.face = aspl.videoRelativeNormalizedRegionFace(fileInfo, videoPixels);
    roi.upperFace = aspl.videoRelativeNormalizedRegionUpperFace(fileInfo, videoPixels);
    roi.lowerFace = aspl.videoRelativeNormalizedRegionLowerFace(fileInfo, videoPixels);
    map(fileInfo.file) = roi;
end
end