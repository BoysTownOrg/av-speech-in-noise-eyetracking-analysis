function fixations = example
filepath = "reference\Subject_DELETE_Session_testing_Experimenter_GD_2023-1-19-16-6-18.txt";
fixations = calculateFixations(parseAvSpeechEyetrackingOutput(File(filepath)));
end