function us = gazeDuration_us(gaze)
us = gaze(end).time_us - gaze(1).time_us;
end