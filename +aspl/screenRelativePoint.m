function point = screenRelativePoint(screen, video, videoRelativePoint)
point.x = screenRelativeCoordinate(videoRelativePoint.x, screen.pixels.width, video.pixels.width, video.scaling);
point.y = screenRelativeCoordinate(videoRelativePoint.y, screen.pixels.height, video.pixels.height, video.scaling);
end

function coordinate = screenRelativeCoordinate(videoRelativeCoordinate, screenPixels, videoPixels, videoScaling)
coordinate = videoPixels * videoScaling * (videoRelativeCoordinate - 0.5)/screenPixels + 0.5;
end