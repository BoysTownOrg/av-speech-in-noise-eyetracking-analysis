function output = parseAvSpeechEyetrackingOutput(file)
nextLine = file.nextLine();
while ~isempty(nextLine)
    labelWithEntry = splitCharArray(nextLine, ': ');
    switch labelWithEntry(1)
        case "tester"
            output.tester = labelWithEntry(2);
        case "subject"
            output.subject = labelWithEntry(2);
        case "session"
            output.session = labelWithEntry(2);
        case "method"
            output.method = labelWithEntry(2);
        case "RME setting"
            output.rmeSetting = labelWithEntry(2);
        case "transducer"
            output.transducer = labelWithEntry(2);
        case "masker"
            output.masker = labelWithEntry(2);
        case "targets"
            output.targets = labelWithEntry(2);
        case "masker level (dB SPL)"
            output.maskerLevel_dB_SPL = integer(labelWithEntry(2));
        case "starting SNR (dB)"
            output.starting_SNR_dB = integer(labelWithEntry(2));
        case "condition"
            output.condition = labelWithEntry(2);
        case "up"
            output.adaptive.up = integer(labelWithEntry(2));
        case "down"
            output.adaptive.down = integer(labelWithEntry(2));
        case "reversals per step size"
            output.adaptive.reversalsPerStepSize = integer(labelWithEntry(2));
        case "step sizes (dB)"
            output.adaptive.stepSizes_dB = integer(labelWithEntry(2));
        case "threshold reversals"
            output.adaptive.thresholdReversals = integer(labelWithEntry(2));
    end
    nextLine = file.nextLine();
end
output.trial = struct([]);
file.nextLine();
nextLine = file.nextLine();
while ischar(nextLine)
    entries = splitCharArray(nextLine, ', ');
    output.trial(end+1).target = entries(2);
    nextLine = file.nextLine();
    labelWithEntry = splitCharArray(nextLine, ': ');
    output.trial(end).eyetracking.targetStartTime_ns = bigInteger(labelWithEntry(2));
    file.nextLine();
    entries = splitNextFileLine(file, ', ');
    output.trial(end).eyetracking.syncTime.eyeTracker_us = bigInteger(entries(1));
    output.trial(end).eyetracking.syncTime.targetPlayer_ns = bigInteger(entries(2));
    file.nextLine();
    output.trial(end).eyetracking.gaze = struct([]);
    nextLine = file.nextLine();
    entries = splitCharArray(nextLine, ", ");
    while numel(entries) == 7 && numel(float(entries(2))) == 2
        output.trial(end).eyetracking.gaze(end+1).time_us = bigInteger(entries(1));
        output.trial(end).eyetracking.gaze(end).left = parseFloatPoint(entries(2));
        output.trial(end).eyetracking.gaze(end).right = parseFloatPoint(entries(3));
        output.trial(end).eyetracking.gaze(end).both = averageOfTwoPoints(...
            output.trial(end).eyetracking.gaze(end).left,...
            output.trial(end).eyetracking.gaze(end).right);
        nextLine = file.nextLine();
        entries = splitCharArray(nextLine, ", ");
    end
end
end

function parsed = integer(input)
parsed = sscanf(input, "%d");
end

function parsed = bigInteger(input)
parsed = sscanf(input, "%ld");
end

function parsed = float(input)
parsed = sscanf(input, "%f");
end

function split = splitCharArray(array, delimiter)
split = string(array).split(delimiter);
end

function split = splitNextFileLine(file, delimiter)
split = splitCharArray(file.nextLine(), delimiter);
end

function point = parseFloatPoint(input)
floats = float(input);
point.x = floats(1);
point.y = floats(2);
end

function point = averageOfTwoPoints(p1, p2)
point.x = nanExcludingMean(p1.x, p2.x);
point.y = nanExcludingMean(p1.y, p2.y);
end

function m = nanExcludingMean(x1, x2)
x = [x1, x2];
m = mean(x(~isnan(x)));
end