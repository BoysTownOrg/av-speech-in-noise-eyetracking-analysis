function fixations = fixations
fileURL = "Subject_test_Session__Experimenter_test_2021-6-26-16-15-52.txt";
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

test = parseAvSpeechEyetrackingOutput(fileURL);
fixations = [];
lastGazeIndexOutsideROI = 0;
while lastGazeIndexOutsideROI < gazeSamples(test, trial) - 1
    firstGazeIndexWithinROI = lastGazeIndexOutsideROI + ...
        firstGazeWithinRegion(...
            [gazeBetween(test, trial, lastGazeIndexOutsideROI+1, gazeSamples(test, trial)-1).left], ...
            screenRelativeRegion(screen, video, roi));
    lastGazeIndexOutsideROI = firstGazeIndexWithinROI + 1;
    while lastGazeIndexOutsideROI ~= gazeSamples(test, trial) + 1 && regionContains(roi, ...
            videoRelativePoint(screen, video, test.eyetracking(trial).gaze(lastGazeIndexOutsideROI).left))
        lastGazeIndexOutsideROI = lastGazeIndexOutsideROI + 1;
    end
    lastGazeIndexWithinROI = lastGazeIndexOutsideROI - 1;
    if lastGazeIndexWithinROI ~= firstGazeIndexWithinROI && ...
            gazeDuration_us(gazeBetween(test, trial, firstGazeIndexWithinROI, lastGazeIndexWithinROI)) >= fixation.threshold.us
        fixations(end+1).duration_ms = gazeDuration_ms(...
            gazeBetween(test, trial, firstGazeIndexWithinROI, lastGazeIndexWithinROI));
        fixations(end).targetStartRelativeTime_ms = targetStartRelativeTime_ms(...
            test.eyetracking(trial), test.eyetracking(trial).gaze(firstGazeIndexWithinROI).time_us);
    end
end
end

function samples = gazeSamples(test, trial)
samples = length(test.eyetracking(trial).gaze);
end

function gaze = gazeBetween(test, trial, first, last)
gaze = test.eyetracking(trial).gaze(first:last);
end