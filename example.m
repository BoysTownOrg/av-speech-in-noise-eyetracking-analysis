function fixationsPerTrial = example
filepath = "reference\Subject_DELETE_Session_testing_Experimenter_GD_2023-1-19-16-6-18.txt";
load('reference\markersAndROIs.mat', 'T3data');
video.pixels.height = 1080;
video.pixels.width = 1920;
video.scaling = 2/3;
screen.pixels.height = 1080;
screen.pixels.width = 1920;
videoRelativeRoiMap = aspl.convertToRoiMap(T3data, video.pixels);
avSpeechResults = aspl.parseAvSpeechEyetrackingOutput(aspl.File(filepath));
fixationThreshold_us = 9000;
for i = 1:numel(avSpeechResults.trial)
    fixationsPerTrial(i) = aspl.getFixations(...
        avSpeechResults.trial(i).eyetracking.gaze, ...
        aspl.screenRelativeRegion(screen, video, ...
            videoRelativeRoiMap(aspl.convertToRoiMapKey(avSpeechResults.trial(i).target.char))), ...
        fixationThreshold_us);
end
end