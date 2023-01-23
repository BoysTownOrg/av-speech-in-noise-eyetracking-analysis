function map = convertToRoiMap(matFileContents)
map = containers.Map();
for i = 1:numel(matFileContents)
    fileInfo = matFileContents{i};
    map(fileInfo.file) = convertToRoi(fileInfo.rectFace);
end
end

function roi = convertToRoi(rectFace)
roi.x = rectFace(1, 1) / 1920;
roi.y = rectFace(1, 2) / 1080;
roi.width = (rectFace(2, 1) - rectFace(1, 1)) / 1920;
roi.height = (rectFace(3, 2) - rectFace(2, 2)) / 1080;
end