function point = screenRelativePoint(screen, video, videoRelativePoint)
point.x = video.pixels.width * video.scaling * (videoRelativePoint.x - 0.5)/screen.pixels.width + 0.5;
point.y = video.pixels.height * video.scaling * (videoRelativePoint.y - 0.5)/screen.pixels.height + 0.5;
end