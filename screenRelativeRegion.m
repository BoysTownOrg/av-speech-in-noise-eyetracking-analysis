function region = screenRelativeRegion(screen, video, videoRelativeRegion)
region = screenRelativePoint(screen, video, videoRelativeRegion);
region.width = videoRelativeRegion.width * video.scaling * video.pixels.width / screen.pixels.width;
region.height = videoRelativeRegion.height * video.scaling * video.pixels.height / screen.pixels.height;
end