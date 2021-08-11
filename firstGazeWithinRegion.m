function index = firstGazeWithinRegion(points, roi)
index = 1;
while index ~= length(points) + 1
    if within(points(index).x, roi.x, roi.width) && within(points(index).y, roi.y, roi.height)
        return
    end
    index = index + 1;
end
end

function answer = within(coordinate, lowerEnd, extent)
answer = coordinate >= lowerEnd && coordinate <= lowerEnd + extent;
end