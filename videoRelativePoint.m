function point = videoRelativePoint(screen, video, data)
point.x = ((data.x - 0.5) * screen.pixels.width + video.pixels.width/2 * video.scaling)/(video.pixels.width * video.scaling);
point.y = ((data.y - 0.5) * screen.pixels.height + video.pixels.height/2 * video.scaling)/(video.pixels.height * video.scaling);
end