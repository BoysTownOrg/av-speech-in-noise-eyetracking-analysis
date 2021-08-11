function index = firstGazeWithinRegion(points, region)
index = 1;
while index ~= length(points) + 1
    if regionContains(region, points(index))
        return
    end
    index = index + 1;
end
end