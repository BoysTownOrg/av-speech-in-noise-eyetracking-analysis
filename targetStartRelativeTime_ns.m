function ns = targetStartRelativeTime_ns(data, eyeTrackerTime_us)
ns = (eyeTrackerTime_us - data.syncTime.eyeTracker_us)*1000 + data.syncTime.targetPlayer_ns - data.targetStartTime_ns;
end