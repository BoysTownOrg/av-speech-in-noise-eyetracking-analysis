function point = videoRelativePoint(screen, video, screenRelativePoint)
point.x = videoRelativeCoordinate(screenRelativePoint.x, screen.pixels.width, video.pixels.width, video.scaling);
point.y = videoRelativeCoordinate(screenRelativePoint.y, screen.pixels.height, video.pixels.height, video.scaling);
end

function coordinate = videoRelativeCoordinate(screenRelativeCoordinate, screenPixels, videoPixels, videoScaling)
coordinate = ((screenRelativeCoordinate - 0.5) * screenPixels + videoPixels/2 * videoScaling)/(videoPixels * videoScaling);
end