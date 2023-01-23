function result = videoRelativeRegion(screen, video, screenRelativeRegion)
result = aspl.videoRelativePoint(screen, video, screenRelativeRegion);
result.width = screenRelativeRegion.width * screen.pixels.width/video.pixels.width/video.scaling;
result.height = screenRelativeRegion.height * screen.pixels.height/video.pixels.height/video.scaling;
end