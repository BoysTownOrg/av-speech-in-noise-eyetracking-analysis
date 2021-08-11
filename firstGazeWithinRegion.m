function index = firstGazeWithinRegion(points, region)
index = 1;
while index ~= length(points) + 1
    if ...
            within(points(index).x, region.x, region.width) && ...
            within(points(index).y, region.y, region.height)
        return
    end
    index = index + 1;
end
end

function answer = within(coordinate, lowerEnd, extent)
answer = coordinate >= lowerEnd && coordinate <= lowerEnd + extent;
end