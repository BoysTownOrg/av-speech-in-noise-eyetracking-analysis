function ms = targetStartRelativeTime_ms(data, eyeTrackerTime_us)
ms = ((eyeTrackerTime_us - data.syncTime.eyeTracker_us)*1000 + data.syncTime.targetPlayer_ns - data.targetStartTime_ns)/1e6;
end