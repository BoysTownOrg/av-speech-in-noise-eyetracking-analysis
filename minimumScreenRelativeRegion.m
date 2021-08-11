function region = minimumScreenRelativeRegion(screenRelativePoints)
x = [screenRelativePoints.x];
y = [screenRelativePoints.y];
minX = min(x);
minY = min(y);
maxX = max(x);
maxY = max(y);
region.x = minX;
region.y = minY;
region.width = maxX - minX;
region.height = maxY - minY;
end