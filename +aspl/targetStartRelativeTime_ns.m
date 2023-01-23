function ns = targetStartRelativeTime_ns(trial, eyeTrackerTime_us)
ns = (eyeTrackerTime_us - trial.syncTime.eyeTracker_us)*1000 + trial.syncTime.targetPlayer_ns - trial.targetStartTime_ns;
end