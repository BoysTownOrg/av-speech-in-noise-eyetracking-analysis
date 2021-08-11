function region = minimumRegion(screenRelativePoints)
xSegment = segment([screenRelativePoints.x]);
region.x = xSegment.end;
region.width = xSegment.length;
ySegment = segment([screenRelativePoints.y]);
region.y = ySegment.end;
region.height = ySegment.length;
end

function segment = segment(x)
if any(isnan(x))
    segment.end = -Inf;
    segment.length = Inf;
else
    minX = min(x);
    maxX = max(x);
    segment.end = minX;
    segment.length = maxX - minX;
end
end