function fixations = example
filepath = "reference\Subject_DELETE_Session_testing_Experimenter_GD_2023-1-19-16-6-18.txt";
load('reference\markersAndROIs.mat', 'T3data');
fixations = calculateFixations(parseAvSpeechEyetrackingOutput(File(filepath)), convertToRoiMap(T3data));
end