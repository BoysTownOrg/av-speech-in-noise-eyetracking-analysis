function trial = example
filepath = "reference\Subject_DELETE_Session_testing_Experimenter_GD_2023-1-19-16-6-18.txt";
load('reference\markersAndROIs.mat', 'T3data');
video.pixels.height = 1080;
video.pixels.width = 1920;
video.scaling = 2/3;
trial = aspl.calculateFixations(...
    aspl.parseAvSpeechEyetrackingOutput(aspl.File(filepath)), ...
    aspl.convertToRoiMap(T3data, video.pixels), ...
    video);
end