function ms = gazeDuration_ms(gaze)
ms = (gaze(end).time_us - gaze(1).time_us)/1000;
end