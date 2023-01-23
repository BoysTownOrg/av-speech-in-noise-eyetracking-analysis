function ms = targetStartRelativeTime_ms(trial, eyeTrackerTime_us)
ms = aspl.targetStartRelativeTime_ns(trial, eyeTrackerTime_us)/1e6;
end