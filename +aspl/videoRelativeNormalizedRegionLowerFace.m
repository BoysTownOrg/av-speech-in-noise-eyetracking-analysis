function roi = videoRelativeNormalizedRegionLowerFace(fileInfo, videoPixels)
rectFace = fileInfo.rectFace;
roi.x = rectFace(1, 1) / videoPixels.width;
roi.y = fileInfo.bisect / videoPixels.height;
roi.width = (rectFace(2, 1) - rectFace(1, 1)) / videoPixels.width;
roi.height = (rectFace(3, 2) - fileInfo.bisect) / videoPixels.height;
end