function test = parseAvSpeechEyetrackingOutput(file)
nextLine = file.nextLine();
while ~isempty(nextLine)
    labelWithEntry = splitCharArray(nextLine, ': ');
    switch labelWithEntry(1)
        case "tester"
            test.tester = labelWithEntry(2);
        case "subject"
            test.subject = labelWithEntry(2);
        case "session"
            test.session = labelWithEntry(2);
        case "method"
            test.method = labelWithEntry(2);
        case "RME setting"
            test.rmeSetting = labelWithEntry(2);
        case "transducer"
            test.transducer = labelWithEntry(2);
        case "masker"
            test.masker = labelWithEntry(2);
        case "targets"
            test.targets = labelWithEntry(2);
        case "masker level (dB SPL)"
            test.maskerLevel_dB_SPL = integer(labelWithEntry(2));
        case "starting SNR (dB)"
            test.starting_SNR_dB = integer(labelWithEntry(2));
        case "condition"
            test.condition = labelWithEntry(2);
        case "up"
            test.adaptive.up = integer(labelWithEntry(2));
        case "down"
            test.adaptive.down = integer(labelWithEntry(2));
        case "reversals per step size"
            test.adaptive.reversalsPerStepSize = integer(labelWithEntry(2));
        case "step sizes (dB)"
            test.adaptive.stepSizes_dB = integer(labelWithEntry(2));
        case "threshold reversals"
            test.adaptive.thresholdReversals = integer(labelWithEntry(2));
    end
    nextLine = file.nextLine();
end
test.trial = struct([]);
file.nextLine();
nextLine = file.nextLine();
while ischar(nextLine)
    entries = splitCharArray(nextLine, ', ');
    test.trial(end+1).target = entries(2);
    nextLine = file.nextLine();
    labelWithEntry = splitCharArray(nextLine, ': ');
    test.trial(end).eyetracking.targetStartTime_ns = bigInteger(labelWithEntry(2));
    file.nextLine();
    entries = splitNextFileLine(file, ', ');
    test.trial(end).eyetracking.syncTime.eyeTracker_us = bigInteger(entries(1));
    test.trial(end).eyetracking.syncTime.targetPlayer_ns = bigInteger(entries(2));
    file.nextLine();
    test.trial(end).eyetracking.gaze = struct([]);
    nextLine = file.nextLine();
    entries = splitCharArray(nextLine, ", ");
    while numel(entries) == 7 && numel(float(entries(2))) == 2
        test.trial(end).eyetracking.gaze(end+1).time_us = bigInteger(entries(1));
        test.trial(end).eyetracking.gaze(end).left = parseFloatPoint(entries(2));
        test.trial(end).eyetracking.gaze(end).right = parseFloatPoint(entries(3));
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