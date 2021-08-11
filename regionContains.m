function answer = regionContains(region, point)
answer = within(point.x, region.x, region.width) && ...
            within(point.y, region.y, region.height);
end

function answer = within(coordinate, lowerEnd, extent)
answer = coordinate >= lowerEnd && coordinate <= lowerEnd + extent;
end