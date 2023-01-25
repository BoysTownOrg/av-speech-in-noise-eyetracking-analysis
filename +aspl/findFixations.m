function fixations = findFixations(gaze, roi, threshold_us)
if isfield(gaze, 'left')
    fixations.left = monocularFixations(gaze, roi, threshold_us, @(gaze)gaze.left);
end
if isfield(gaze, 'right')
    fixations.right = monocularFixations(gaze, roi, threshold_us, @(gaze)gaze.right);
end
end

function fixations = monocularFixations(gaze, roi, threshold_us, pointFromGaze)
fixations = [];
firstGazeIndexOutsideROI = 0;
while firstGazeIndexOutsideROI < numel(gaze) - 1
    firstGazeIndexWithinROI = firstGazeIndexOutsideROI + ...
        aspl.firstGazeWithinRegion(...
        pointFromGaze(gaze(firstGazeIndexOutsideROI+1:end-1)), ...
        roi);
    firstGazeIndexOutsideROI = firstGazeIndexWithinROI + 1;
    while firstGazeIndexOutsideROI ~= numel(gaze) + 1 ...
            && aspl.regionContains(roi, pointFromGaze(gaze(firstGazeIndexOutsideROI)))
        firstGazeIndexOutsideROI = firstGazeIndexOutsideROI + 1;
    end
    lastGazeIndexWithinROI = firstGazeIndexOutsideROI - 1;
    if lastGazeIndexWithinROI ~= firstGazeIndexWithinROI && ...
            aspl.gazeDuration_us(gaze(firstGazeIndexWithinROI:lastGazeIndexWithinROI)) ...
            >= threshold_us
        fixations(end+1).duration_ms = aspl.gazeDuration_ms(...
            gaze(firstGazeIndexWithinROI:lastGazeIndexWithinROI));
        fixations(end).firstGazeIndex = firstGazeIndexWithinROI;
    end
end
end