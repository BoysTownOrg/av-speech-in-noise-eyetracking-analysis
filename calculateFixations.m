function fixations = calculateFixations(results)
screen.pixels.height = 1080;
screen.pixels.width = 1920;
video.pixels.height = 1080;
video.pixels.width = 1920;
video.scaling = 2/3;
fixation.threshold.us = 90000;
trial = 1;
roi.x = 0.25;
roi.y = 0.25;
roi.width = 0.5;
roi.height = 0.5;

fixations = [];
lastGazeIndexOutsideROI = 0;
while lastGazeIndexOutsideROI < gazeSamples(results, trial) - 1
    firstGazeIndexWithinROI = lastGazeIndexOutsideROI + ...
        firstGazeWithinRegion(...
            [gazeBetween(results, trial, lastGazeIndexOutsideROI+1, gazeSamples(results, trial)-1).left], ...
            screenRelativeRegion(screen, video, roi));
    lastGazeIndexOutsideROI = firstGazeIndexWithinROI + 1;
    while lastGazeIndexOutsideROI ~= gazeSamples(results, trial) + 1 && regionContains(roi, ...
            videoRelativePoint(screen, video, results.eyetracking(trial).gaze(lastGazeIndexOutsideROI).left))
        lastGazeIndexOutsideROI = lastGazeIndexOutsideROI + 1;
    end
    lastGazeIndexWithinROI = lastGazeIndexOutsideROI - 1;
    if lastGazeIndexWithinROI ~= firstGazeIndexWithinROI && ...
            gazeDuration_us(gazeBetween(results, trial, firstGazeIndexWithinROI, lastGazeIndexWithinROI)) >= fixation.threshold.us
        fixations(end+1).duration_ms = gazeDuration_ms(...
            gazeBetween(results, trial, firstGazeIndexWithinROI, lastGazeIndexWithinROI));
        fixations(end).targetStartRelativeTime_ms = targetStartRelativeTime_ms(...
            results.eyetracking(trial), results.eyetracking(trial).gaze(firstGazeIndexWithinROI).time_us);
    end
end
end

function samples = gazeSamples(results, trial)
samples = length(results.eyetracking(trial).gaze);
end

function gaze = gazeBetween(results, trial, first, last)
gaze = results.eyetracking(trial).gaze(first:last);
end