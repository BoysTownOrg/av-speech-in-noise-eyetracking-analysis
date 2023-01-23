function output = calculateFixations(results, roiMap, video)
screen.pixels.height = 1080;
screen.pixels.width = 1920;
fixation.threshold.us = 90000;
roi.x = 0.25;
roi.y = 0.25;
roi.width = 0.5;
roi.height = 0.5;

output(numel(results.trial)).fixations = struct([]);
for trial = 1:numel(results.trial)
    lastGazeIndexOutsideROI = 0;
    while lastGazeIndexOutsideROI < gazeSamples(results, trial) - 1
        firstGazeIndexWithinROI = lastGazeIndexOutsideROI + ...
            firstGazeWithinRegion(...
            [gazeBetween(results, trial, lastGazeIndexOutsideROI+1, gazeSamples(results, trial)-1).left], ...
            screenRelativeRegion(screen, video, roi));
        lastGazeIndexOutsideROI = firstGazeIndexWithinROI + 1;
        while lastGazeIndexOutsideROI ~= gazeSamples(results, trial) + 1 && regionContains(roi, ...
                videoRelativePoint(screen, video, results.trial(trial).eyetracking.gaze(lastGazeIndexOutsideROI).left))
            lastGazeIndexOutsideROI = lastGazeIndexOutsideROI + 1;
        end
        lastGazeIndexWithinROI = lastGazeIndexOutsideROI - 1;
        if lastGazeIndexWithinROI ~= firstGazeIndexWithinROI && ...
                gazeDuration_us(gazeBetween(results, trial, firstGazeIndexWithinROI, lastGazeIndexWithinROI)) >= fixation.threshold.us
            output(trial).fixations(end+1).duration_ms = gazeDuration_ms(...
                gazeBetween(results, trial, firstGazeIndexWithinROI, lastGazeIndexWithinROI));
            output(trial).fixations(end).targetStartRelativeTime_ms = targetStartRelativeTime_ms(...
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