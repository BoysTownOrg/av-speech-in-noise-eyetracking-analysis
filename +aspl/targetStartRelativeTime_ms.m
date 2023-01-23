function ms = targetStartRelativeTime_ms(data, eyeTrackerTime_us)
ms = aspl.targetStartRelativeTime_ns(data, eyeTrackerTime_us)/1e6;
end