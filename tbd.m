function tbd(fileName)
fileID = fopen(fileName);
nextLine = string(fgetl(fileID));
while ~nextLine.contains("target start time (ns)")
    nextLine = string(fgetl(fileID));
end
targetStartTimeLineSplit = nextLine.split(':');
targetStartTime_ns = sscanf(targetStartTimeLineSplit(2), "%ld");
fgetl(fileID);
nextLine = string(fgetl(fileID));
synchronizationSplit = nextLine.split(',');
eyeTrackerSyncTime_us = sscanf(synchronizationSplit(1), "%ld");
targetPlayerSyncTime_ns = sscanf(synchronizationSplit(2), "%ld");
while fgetl(fileID) ~= "eye tracker time (us), left gaze [x y], right gaze [x y]"
end
eyeGaze = struct([]);
while 1
    csvEntries = string(fgetl(fileID)).split(',');
    if numel(csvEntries) ~= 3, break, end
    eyeGaze(end+1).time_us = sscanf(csvEntries(1), "%ld");
    leftPoint = parseTwoFloats(csvEntries(2));
    rightPoint = parseTwoFloats(csvEntries(3));
    eyeGaze(end).left.x = leftPoint(1);
    eyeGaze(end).left.y = leftPoint(2);
    eyeGaze(end).right.x = rightPoint(1);
    eyeGaze(end).right.y = rightPoint(2);
end
fclose(fileID);
axis = gca;
axis.XLim = [-0.1, 1.1];
axis.YLim = [-0.1, 1.1];
screen = line([0, 1, 1, 0, 0], [0, 0, 1, 1, 0]);
leftGazeMarker = line;
leftGazeMarker.XData = [];
leftGazeMarker.YData = [];
leftGazeMarker.Marker = "x";
leftGazeMarker.MarkerSize = 16;
leftGazeMarker.LineWidth = 1;
leftGazeMarker.Color = [0.6350 0.0780 0.1840];
rightGazeMarker = line;
rightGazeMarker.XData = [];
rightGazeMarker.YData = [];
rightGazeMarker.Marker = "x";
rightGazeMarker.MarkerSize = 16;
rightGazeMarker.LineWidth = 1;
rightGazeMarker.Color = [0 0.4470 0.7410];
leftFixation = line;
leftFixation.Color = [0.8500 0.3250 0.0980];
rightFixation = line;
rightFixation.Color = [0.3010 0.7450 0.9330];
sampleRateHz = 60;
fixationDurationMs = 90;
samplesPerFixation = ceil(fixationDurationMs*sampleRateHz/1000);
for i = 1:length(eyeGaze) - samplesPerFixation
    points = [eyeGaze(i:i+samplesPerFixation).left];
    maxx = max([points.x]);
    minx = min([points.x]);
    maxy = max([points.y]);
    miny = min([points.y]);
    leftFixation.XData = [minx, maxx, maxx, minx, minx];
    leftFixation.YData = [miny, miny, maxy, maxy, miny];
    leftGazeMarker.XData = eyeGaze(i+samplesPerFixation).left.x;
    leftGazeMarker.YData = eyeGaze(i+samplesPerFixation).left.y;
    
    points = [eyeGaze(i:i+samplesPerFixation).right];
    maxx = max([points.x]);
    minx = min([points.x]);
    maxy = max([points.y]);
    miny = min([points.y]);
    rightFixation.XData = [minx, maxx, maxx, minx, minx];
    rightFixation.YData = [miny, miny, maxy, maxy, miny];
    rightGazeMarker.XData = eyeGaze(i+samplesPerFixation).right.x;
    rightGazeMarker.YData = eyeGaze(i+samplesPerFixation).right.y;
    if (eyeGaze(i+samplesPerFixation).time_us - eyeTrackerSyncTime_us)*1000 + targetPlayerSyncTime_ns > targetStartTime_ns
        screen.Color = [rand rand rand];
    end
    pause(4/sampleRateHz);
    drawnow;
end
delete(leftFixation);
delete(rightFixation);
delete(leftGazeMarker);
delete(rightGazeMarker);
delete(screen);
end

function output = parseTwoFloats(input)
output = sscanf(input, "%f");
if isempty(output), output = [nan, nan];
end
end