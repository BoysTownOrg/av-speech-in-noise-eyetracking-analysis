test = parseAvSpeechEyetrackingOutput("Subject_test_Session__Experimenter_test_2021-6-26-16-15-52.txt");
screen.pixels.height = 1080;
screen.pixels.width = 1920;
video.pixels.height = 1080;
video.pixels.width = 1920;
video.scaling = 2/3;
fixation.threshold.us = 90000;
roi.x = 0.508;
roi.y = 0.518;
roi.width = 0.03;
roi.height = 0.03;
fixations = [];
firstGazeIndexWithinROI = 0;
while 1
    firstGazeIndexWithinROI = firstGazeIndexWithinROI + firstGazeWithinRegion([test.eyetracking(1).gaze(firstGazeIndexWithinROI + 1:end-1).left], screenRelativeRegion(screen, video, roi));
    if firstGazeIndexWithinROI == length(test.eyetracking(1).gaze)
        break
    else
        lastGazeIndexOutsideROI = firstGazeIndexWithinROI + 1;
        while regionContains(roi, videoRelativePoint(screen, video, test.eyetracking(1).gaze(lastGazeIndexOutsideROI).left))
            lastGazeIndexOutsideROI = lastGazeIndexOutsideROI + 1;
            if lastGazeIndexOutsideROI == length(test.eyetracking(1).gaze) + 1
                break
            end
        end
        if lastGazeIndexOutsideROI ~= firstGazeIndexWithinROI + 1 && gazeDuration_us(test.eyetracking(1).gaze(firstGazeIndexWithinROI:lastGazeIndexOutsideROI-1)) >= fixation.threshold.us
            fixations(end+1).duration_ms = gazeDuration_ms(test.eyetracking(1).gaze(firstGazeIndexWithinROI:lastGazeIndexOutsideROI-1));
            fixations(end).targetStartRelativeTime_ms = targetStartRelativeTime_ms(test.eyetracking(1), test.eyetracking(1).gaze(firstGazeIndexWithinROI).time_us);
        end
        if lastGazeIndexOutsideROI > length(test.eyetracking(1).gaze) - 2
            break
        else
            firstGazeIndexWithinROI = lastGazeIndexOutsideROI;
        end
    end
end