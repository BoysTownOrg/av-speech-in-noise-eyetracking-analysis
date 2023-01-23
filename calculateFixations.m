function output = calculateFixations(results, roiMap, video)
screen.pixels.height = 1080;
screen.pixels.width = 1920;
fixation.threshold.us = 90000;

output(numel(results.trial)).fixations = struct([]);
for trial = 1:numel(results.trial)
    roi = roiMap(aspl.convertToRoiMapKey(results.trial(trial).target.char));
    lastGazeIndexOutsideROI = 0;
    while lastGazeIndexOutsideROI < gazeSamples(results, trial) - 1
        firstGazeIndexWithinROI = lastGazeIndexOutsideROI + ...
            aspl.firstGazeWithinRegion(...
            [gazeBetween(results, trial, lastGazeIndexOutsideROI+1, gazeSamples(results, trial)-1).left], ...
            aspl.screenRelativeRegion(screen, video, roi));
        lastGazeIndexOutsideROI = firstGazeIndexWithinROI + 1;
        while lastGazeIndexOutsideROI ~= gazeSamples(results, trial) + 1 && aspl.regionContains(roi, ...
                aspl.videoRelativePoint(screen, video, results.trial(trial).eyetracking.gaze(lastGazeIndexOutsideROI).left))
            lastGazeIndexOutsideROI = lastGazeIndexOutsideROI + 1;
        end
        lastGazeIndexWithinROI = lastGazeIndexOutsideROI - 1;
        if lastGazeIndexWithinROI ~= firstGazeIndexWithinROI && ...
                aspl.gazeDuration_us(gazeBetween(results, trial, firstGazeIndexWithinROI, lastGazeIndexWithinROI)) >= fixation.threshold.us
            output(trial).fixations(end+1).duration_ms = aspl.gazeDuration_ms(...
                gazeBetween(results, trial, firstGazeIndexWithinROI, lastGazeIndexWithinROI));
            output(trial).fixations(end).targetStartRelativeTime_ms = aspl.targetStartRelativeTime_ms(...
                results.trial(trial).eyetracking, results.trial(trial).eyetracking.gaze(firstGazeIndexWithinROI).time_us);
        end
    end
end
end

function samples = gazeSamples(results, trial)
samples = length(results.trial(trial).eyetracking.gaze);
end

function gaze = gazeBetween(results, trial, first, last)
gaze = results.trial(trial).eyetracking.gaze(first:last);
end