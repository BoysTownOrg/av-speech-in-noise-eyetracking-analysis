function fixations = getFixations(gaze, screenRelativeRoi, threshold_us)
if isfield(gaze, 'left')
    fixations.left = tbd(gaze, screenRelativeRoi, threshold_us, @(gaze)gaze.left);
end
if isfield(gaze, 'right')
    fixations.right = tbd(gaze, screenRelativeRoi, threshold_us, @(gaze)gaze.right);
end
end

function fixations = tbd(gaze, screenRelativeRoi, threshold_us, pointFromGaze)
fixations = [];
firstGazeIndexOutsideROI = 0;
while firstGazeIndexOutsideROI < numel(gaze) - 1
    firstGazeIndexWithinROI = firstGazeIndexOutsideROI + ...
        aspl.firstGazeWithinRegion(...
        [pointFromGaze(gaze(firstGazeIndexOutsideROI+1:end-1))], ...
        screenRelativeRoi);
    firstGazeIndexOutsideROI = firstGazeIndexWithinROI + 1;
    while firstGazeIndexOutsideROI ~= numel(gaze) + 1 ...
            && aspl.regionContains(screenRelativeRoi, pointFromGaze(gaze(firstGazeIndexOutsideROI)))
        firstGazeIndexOutsideROI = firstGazeIndexOutsideROI + 1;
    end
    lastGazeIndexWithinROI = firstGazeIndexOutsideROI - 1;
    if lastGazeIndexWithinROI ~= firstGazeIndexWithinROI && ...
            aspl.gazeDuration_us(gaze(firstGazeIndexWithinROI:lastGazeIndexWithinROI)) ...
            >= threshold_us
        fixations(end+1).duration_ms = aspl.gazeDuration_ms(...
            gaze(firstGazeIndexWithinROI:lastGazeIndexWithinROI));
    end
end
end