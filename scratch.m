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
lastGazeIndexOutsideROI = 0;
while 1
    firstGazeIndexWithinROI = lastGazeIndexOutsideROI + firstGazeWithinRegion([test.eyetracking(1).gaze(lastGazeIndexOutsideROI + 1:end-1).left], screenRelativeRegion(screen, video, roi));
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
        lastGazeIndexWithinROI = lastGazeIndexOutsideROI - 1;
        if lastGazeIndexWithinROI ~= firstGazeIndexWithinROI && gazeDuration_us(test.eyetracking(1).gaze(firstGazeIndexWithinROI:lastGazeIndexWithinROI)) >= fixation.threshold.us
            fixations(end+1).duration_ms = gazeDuration_ms(test.eyetracking(1).gaze(firstGazeIndexWithinROI:lastGazeIndexWithinROI));
            fixations(end).targetStartRelativeTime_ms = targetStartRelativeTime_ms(test.eyetracking(1), test.eyetracking(1).gaze(firstGazeIndexWithinROI).time_us);
        end
        if lastGazeIndexOutsideROI > length(test.eyetracking(1).gaze) - 2
            break
        end
    end
end