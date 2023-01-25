function fixations = getFixations(gaze, screenRelativeRoi, threshold_us)
fixations.left = struct([]);
lastGazeIndexOutsideROI = 0;
while lastGazeIndexOutsideROI < numel(gaze) - 1
    firstGazeIndexWithinROI = lastGazeIndexOutsideROI + ...
        aspl.firstGazeWithinRegion(...
        [gaze(lastGazeIndexOutsideROI+1:end-1).left], ...
        screenRelativeRoi);
    lastGazeIndexOutsideROI = firstGazeIndexWithinROI + 1;
    while lastGazeIndexOutsideROI ~= numel(gaze) + 1 && aspl.regionContains(screenRelativeRoi, gaze(lastGazeIndexOutsideROI).left)
        lastGazeIndexOutsideROI = lastGazeIndexOutsideROI + 1;
    end
    lastGazeIndexWithinROI = lastGazeIndexOutsideROI - 1;
    if lastGazeIndexWithinROI ~= firstGazeIndexWithinROI && ...
            aspl.gazeDuration_us(gaze(firstGazeIndexWithinROI:lastGazeIndexWithinROI)) >= threshold_us
        fixations.left(end+1).duration_ms = aspl.gazeDuration_ms(...
            gaze(firstGazeIndexWithinROI:lastGazeIndexWithinROI));
    end
end
end