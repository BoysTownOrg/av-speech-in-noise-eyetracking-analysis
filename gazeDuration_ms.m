function ms = gazeDuration_ms(data)
ms = (data(end).time_us - data(1).time_us)/1000;
end