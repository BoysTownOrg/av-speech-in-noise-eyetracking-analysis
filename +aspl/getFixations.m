function fixations = getFixations(gaze, screenRelativeRoi, threshold_us)
fixations.left = struct([]);
firstGazeIndexOutsideROI = 0;
while firstGazeIndexOutsideROI < numel(gaze) - 1
    firstGazeIndexWithinROI = firstGazeIndexOutsideROI + ...
        aspl.firstGazeWithinRegion(...
        [gaze(firstGazeIndexOutsideROI+1:end-1).left], ...
        screenRelativeRoi);
    firstGazeIndexOutsideROI = firstGazeIndexWithinROI + 1;
    while firstGazeIndexOutsideROI ~= numel(gaze) + 1 && aspl.regionContains(screenRelativeRoi, gaze(firstGazeIndexOutsideROI).left)
        firstGazeIndexOutsideROI = firstGazeIndexOutsideROI + 1;
    end
    lastGazeIndexWithinROI = firstGazeIndexOutsideROI - 1;
    if lastGazeIndexWithinROI ~= firstGazeIndexWithinROI && ...
            aspl.gazeDuration_us(gaze(firstGazeIndexWithinROI:lastGazeIndexWithinROI)) >= threshold_us
        fixations.left(end+1).duration_ms = aspl.gazeDuration_ms(...
            gaze(firstGazeIndexWithinROI:lastGazeIndexWithinROI));
    end
end
end