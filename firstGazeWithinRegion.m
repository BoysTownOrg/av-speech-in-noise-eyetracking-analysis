function index = firstGazeWithinRegion(points, region)
index = 1;
while index ~= length(points) + 1 && ~regionContains(region, points(index))
    index = index + 1;
end
end