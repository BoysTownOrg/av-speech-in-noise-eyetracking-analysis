test = parseAvSpeechEyetrackingOutput("Subject_test_Session__Experimenter_test_2021-6-26-16-15-52.txt");
screen.pixels.height = 1080;
screen.pixels.width = 1920;
video.pixels.height = 1080;
video.pixels.width = 1920;
video.scaling = 2/3;
roi.x = 0.508;
roi.y = 0.518;
roi.width = 0.03;
roi.height = 0.03;
fixations = [];
head = 1;
while 1
    head = head - 1 + firstGazeWithinRegion([test.eyetracking(1).gaze(head:end-1).left], screenRelativeRegion(screen, video, roi));
    if head == length(test.eyetracking(1).gaze)
        break
    else
        tail = head + 1;
        lastTestedTail = head;
        while regionContains(roi, videoRelativePoint(screen, video, test.eyetracking(1).gaze(tail).left))
            lastTestedTail = tail;
            if tail == length(test.eyetracking(1).gaze)
                break
            end
            tail = tail + 1;
        end
        if lastTestedTail ~= head && gazeDuration_us(test.eyetracking(1).gaze(head:lastTestedTail)) >= 90000
            fixations(end+1).duration_ms = gazeDuration_ms(test.eyetracking(1).gaze(head:lastTestedTail));
            fixations(end).targetStartRelativeTime_ms = targetStartRelativeTime_ms(test.eyetracking(1), test.eyetracking(1).gaze(head).time_us);
        end
        if tail == length(test.eyetracking(1).gaze) || tail == length(test.eyetracking(1).gaze) - 1
            break
        else
            head = tail + 1;
        end
    end
end