function trial = calculateFixations(results, roiMap, video)
screen.pixels.height = 1080;
screen.pixels.width = 1920;
fixation.threshold.us = 90000;

trial(numel(results.trial)).fixations.left = struct([]);
trial(numel(results.trial)).fixations.right = struct([]);
for i = 1:numel(results.trial)
    trial(i).fixations.left = tbd(results, roiMap, video, screen, fixation, i, @(gaze)gaze.left);
    trial(i).fixations.right = tbd(results, roiMap, video, screen, fixation, i, @(gaze)gaze.right);
end
end

function fixations = tbd(results, roiMap, video, screen, fixation, i, pointFromGaze)
fixations = struct([]);
roi = roiMap(aspl.convertToRoiMapKey(results.trial(i).target.char));
lastGazeIndexOutsideROI = 0;
while lastGazeIndexOutsideROI < gazeSamples(results, i) - 1
    firstGazeIndexWithinROI = lastGazeIndexOutsideROI + ...
        aspl.firstGazeWithinRegion(...
        [pointFromGaze(gazeBetween(results, i, lastGazeIndexOutsideROI+1, gazeSamples(results, i)-1))], ...
        aspl.screenRelativeRegion(screen, video, roi));
    lastGazeIndexOutsideROI = firstGazeIndexWithinROI + 1;
    while lastGazeIndexOutsideROI ~= gazeSamples(results, i) + 1 && aspl.regionContains(roi, ...
            aspl.videoRelativePoint(screen, video, pointFromGaze(results.trial(i).eyetracking.gaze(lastGazeIndexOutsideROI))))
        lastGazeIndexOutsideROI = lastGazeIndexOutsideROI + 1;
    end
    lastGazeIndexWithinROI = lastGazeIndexOutsideROI - 1;
    if lastGazeIndexWithinROI ~= firstGazeIndexWithinROI && ...
            aspl.gazeDuration_us(gazeBetween(results, i, firstGazeIndexWithinROI, lastGazeIndexWithinROI)) >= fixation.threshold.us
        fixations(end+1).duration_ms = aspl.gazeDuration_ms(...
            gazeBetween(results, i, firstGazeIndexWithinROI, lastGazeIndexWithinROI));
        fixations(end).targetStartRelativeTime_ms = aspl.targetStartRelativeTime_ms(...
            results.trial(i).eyetracking, results.trial(i).eyetracking.gaze(firstGazeIndexWithinROI).time_us);
    end
end
end

function samples = gazeSamples(results, trial)
samples = length(results.trial(trial).eyetracking.gaze);
end

function gaze = gazeBetween(results, trial, first, last)
gaze = results.trial(trial).eyetracking.gaze(first:last);
end