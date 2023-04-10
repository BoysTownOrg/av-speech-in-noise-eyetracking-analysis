function fixationsPerTrial = findFixationsPerTrial(filepath, T3data)
video.pixels.height = 1080;
video.pixels.width = 1920;
video.scaling = 2/3;
screen.pixels.height = 1080;
screen.pixels.width = 1920;
videoRelativeRoiMap = aspl.convertToRoiMap(T3data, video.pixels);
avSpeechResults = aspl.parseAvSpeechEyetrackingOutput(aspl.File(filepath));
fixationThreshold_us = 90000;
screenRegion.x = 0;
screenRegion.y = 0;
screenRegion.width = 1;
screenRegion.height = 1;
for trial = 1:numel(avSpeechResults.trial)
    avSpeechTrialResults = avSpeechResults.trial(trial);
    eyetrackingResults = avSpeechTrialResults.eyetracking;
    roi = videoRelativeRoiMap(aspl.convertToRoiMapKey(avSpeechTrialResults.target.char));
    fixationsPerTrial(trial).face = aspl.findFixations(...
        eyetrackingResults.gaze, ...
        aspl.screenRelativeRegion(screen, video, roi.face), ...
        fixationThreshold_us);
    fixationsPerTrial(trial).upperFace = aspl.findFixations(...
        eyetrackingResults.gaze, ...
        aspl.screenRelativeRegion(screen, video, roi.upperFace), ...
        fixationThreshold_us);
    fixationsPerTrial(trial).lowerFace = aspl.findFixations(...
        eyetrackingResults.gaze, ...
        aspl.screenRelativeRegion(screen, video, roi.lowerFace), ...
        fixationThreshold_us);
    fixationsPerTrial(trial).screen = aspl.findFixations(...
        eyetrackingResults.gaze, ...
        screenRegion, ...
        fixationThreshold_us);
    fixationsPerTrial(trial).face.left = addTargetStartTimes(fixationsPerTrial(trial).face.left, eyetrackingResults);
    fixationsPerTrial(trial).face.right = addTargetStartTimes(fixationsPerTrial(trial).face.right, eyetrackingResults);
    fixationsPerTrial(trial).upperFace.left = addTargetStartTimes(fixationsPerTrial(trial).upperFace.left, eyetrackingResults);
    fixationsPerTrial(trial).upperFace.right = addTargetStartTimes(fixationsPerTrial(trial).upperFace.right, eyetrackingResults);
    fixationsPerTrial(trial).lowerFace.left = addTargetStartTimes(fixationsPerTrial(trial).lowerFace.left, eyetrackingResults);
    fixationsPerTrial(trial).lowerFace.right = addTargetStartTimes(fixationsPerTrial(trial).lowerFace.right, eyetrackingResults);
    fixationsPerTrial(trial).screen.left = addTargetStartTimes(fixationsPerTrial(trial).screen.left, eyetrackingResults);
    fixationsPerTrial(trial).screen.right = addTargetStartTimes(fixationsPerTrial(trial).screen.right, eyetrackingResults);
end
end

function fixations = addTargetStartTimes(fixations, eyetrackingResults)
    for i = 1:numel(fixations)
        fixations(i).targetStartRelativeTime_ms = aspl.targetStartRelativeTime_ms(...
            eyetrackingResults, ...
            eyetrackingResults.gaze(fixations(i).firstGazeIndex).time_us);
    end
end