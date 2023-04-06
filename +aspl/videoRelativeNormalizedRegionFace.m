function roi = videoRelativeNormalizedRegionFace(fileInfo, videoPixels)
rectFace = fileInfo.rectFace;
roi.x = rectFace(1, 1) / videoPixels.width;
roi.y = rectFace(1, 2) / videoPixels.height;
roi.width = (rectFace(2, 1) - rectFace(1, 1)) / videoPixels.width;
roi.height = (rectFace(3, 2) - rectFace(2, 2)) / videoPixels.height;
end