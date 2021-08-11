test = parseAvSpeechEyetrackingOutput("Subject_test_Session__Experimenter_test_2021-6-26-16-15-52.txt");
screen.pixels.height = 1080;
screen.pixels.width = 1920;
video.pixels.height = 1080;
video.pixels.width = 1920;
video.scaling = 2/3;
roi.x = 0.25;
roi.y = 0.3;
roi.width = 0.5;
roi.height = 0.2;
head = 1;
head = firstGazeWithinRegion([test.eyetracking(1).gaze(head:end).left], screenRelativeRegion(screen, video, roi));
if head ~= length(test.eyetracking(1).gaze) + 1
    tail = head + 1;
    while tail ~= length(test.eyetracking(1).gaze) + 1 && gazeDuration_us(test.eyetracking(1).gaze(head:tail)) < 90000
        tail = tail + 1;
    end
    if gazeDuration_us(test.eyetracking(1).gaze(head:tail)) >= 90000
        videoRelativeRegion(screen, video, minimumRegion([test.eyetracking(1).gaze(head:tail).left]))
    end
end