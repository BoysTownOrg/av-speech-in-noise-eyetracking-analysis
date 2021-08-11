classdef GazeAnalysisTestCase < matlab.unittest.TestCase
    methods(Test)
        function targetStartRelativeTime_ms(self)
            data.targetStartTime_ns = 335843231518711;
            data.syncTime.eyeTracker_us = 1208315441434;
            data.syncTime.targetPlayer_ns = 335843075631090;
            self.verifyEqual(...
                targetStartRelativeTime_ms(data, 1208316167880), ...
                (...
                (1208316167880 - 1208315441434)*1000 + ...
                335843075631090 - ...
                335843231518711)/1e6...
            );
        end
        
        function targetStartRelativeTime_ns(self)
            data.targetStartTime_ns = 335843231518711;
            data.syncTime.eyeTracker_us = 1208315441434;
            data.syncTime.targetPlayer_ns = 335843075631090;
            self.verifyEqual(...
                targetStartRelativeTime_ns(data, 1208316167880), ...
                (1208316167880 - 1208315441434)*1000 + ...
                335843075631090 - 335843231518711 ...
            );
        end
        
        function gazeDuration_ms(self)
            gaze(1).time_us = 1208316167880;
            gaze(2).time_us = 1208316184536;
            gaze(3).time_us = 1208316201191;
            self.verifyEqual(gazeDuration_ms(gaze), (1208316201191 - 1208316167880)/1000);
        end
        
        function gazeDuration_us(self)
            gaze(1).time_us = 1208316167880;
            gaze(2).time_us = 1208316184536;
            gaze(3).time_us = 1208316201191;
            self.verifyEqual(gazeDuration_us(gaze), 1208316201191 - 1208316167880);
        end
        
        function minimumRegion(self)
            points(1).x = 0.5089;
            points(1).y = 0.5194;
            points(2).x = 0.5080;
            points(2).y = 0.5252;
            points(3).x = 0.5086;
            points(3).y = 0.5239;
            region = minimumRegion(points);
            self.verifyEqual(region.x, 0.5080)
            self.verifyEqual(region.y, 0.5194)
            self.verifyEqual(region.width, 0.5089 - 0.5080)
            self.verifyEqual(region.height, 0.5252 - 0.5194)
        end
        
        function minimumRegionHavingNaN(self)
            points(1).x = 0.5089;
            points(1).y = 0.5194;
            points(2).x = NaN;
            points(2).y = 0.5252;
            points(3).x = 0.5086;
            points(3).y = 0.5239;
            region = minimumRegion(points);
            self.verifyEqual(region.x, -Inf)
            self.verifyEqual(region.y, 0.5194)
            self.verifyEqual(region.width, Inf)
            self.verifyEqual(region.height, 0.5252 - 0.5194)
        end
        
        function videoRelativePoint(self)
            screen.pixels.width = 1600;
            screen.pixels.height = 900;
            video.pixels.width = 1920;
            video.pixels.height = 1080;
            video.scaling = 2/3;
            screenRelativePoint.x = 0.45;
            screenRelativePoint.y = 0.34;
            result = videoRelativePoint(screen, video, screenRelativePoint);
            self.verifyEqual(result.x, (0.45 - 0.5) * 1600/1920/(2/3) + 0.5);
            self.verifyEqual(result.y, (0.34 - 0.5) * 900 /1080/(2/3) + 0.5);
        end
        
        function videoRelativeRegion(self)
            screen.pixels.width = 1600;
            screen.pixels.height = 900;
            video.pixels.width = 1920;
            video.pixels.height = 1080;
            video.scaling = 2/3;
            screenRelativeRegion.x = 0.45;
            screenRelativeRegion.y = 0.34;
            screenRelativeRegion.width = 0.03;
            screenRelativeRegion.height = 0.11;
            result = videoRelativeRegion(screen, video, screenRelativeRegion);
            self.verifyEqual(result.x, (0.45 - 0.5) * 1600/1920/(2/3) + 0.5);
            self.verifyEqual(result.y, (0.34 - 0.5) * 900 /1080/(2/3) + 0.5);
            self.verifyEqual(result.width,  0.03 * 1600/1920/(2/3));
            self.verifyEqual(result.height, 0.11 * 900 /1080/(2/3));
        end
        
        function screenRelativePoint(self)
            screen.pixels.width = 1600;
            screen.pixels.height = 900;
            video.pixels.width = 1920;
            video.pixels.height = 1080;
            video.scaling = 2/3;
            videoRelativePoint.x = 0.45;
            videoRelativePoint.y = 0.34;
            result = screenRelativePoint(screen, video, videoRelativePoint);
            self.verifyEqual(result.x, 1920 * 2/3 * (0.45 - 0.5)/1600 + 0.5);
            self.verifyEqual(result.y, 1080 * 2/3 * (0.34 - 0.5)/900  + 0.5);
        end
        
        function screenRelativeRegion(self)
            screen.pixels.width = 1600;
            screen.pixels.height = 900;
            video.pixels.width = 1920;
            video.pixels.height = 1080;
            video.scaling = 2/3;
            videoRelativeRegion.x = 0.45;
            videoRelativeRegion.y = 0.34;
            videoRelativeRegion.width = 0.03;
            videoRelativeRegion.height = 0.11;
            result = screenRelativeRegion(screen, video, videoRelativeRegion);
            self.verifyEqual(result.x, 1920 * 2/3 * (0.45 - 0.5)/1600 + 0.5);
            self.verifyEqual(result.y, 1080 * 2/3 * (0.34 - 0.5)/900  + 0.5);
            self.verifyEqual(result.width,  0.03 * (2/3) * 1920/1600);
            self.verifyEqual(result.height,  0.11 * (2/3) * 1080/900);
        end
        
        function firstGazeWithinROI(self)
            points(1).x = 0.5089;
            points(1).y = 0.5194;
            points(2).x = 0.5080;
            points(2).y = 0.5252;
            points(3).x = 0.5086;
            points(3).y = 0.5239;
            roi.x = 0.4781;
            roi.y = 0.458;
            roi.width = 0.03;
            roi.height = 0.07;
            self.verifyEqual(firstGazeWithinROI(points, roi), 2);
        end
    end
end