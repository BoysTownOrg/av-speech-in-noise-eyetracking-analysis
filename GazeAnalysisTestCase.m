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
        
        function gazeDuration_ms(self)
            gaze(1).time_us = 1208316167880;
            gaze(2).time_us = 1208316184536;
            gaze(3).time_us = 1208316201191;
            self.verifyEqual(gazeDuration_ms(gaze), (1208316201191 - 1208316167880)/1000);
        end
        
        function minimumScreenRelativeRegion(self)
            screenRelativePoints(1).x = 0.5089;
            screenRelativePoints(1).y = 0.5194;
            screenRelativePoints(2).x = 0.5080;
            screenRelativePoints(2).y = 0.5252;
            screenRelativePoints(3).x = 0.5086;
            screenRelativePoints(3).y = 0.5239;
            region = minimumScreenRelativeRegion(screenRelativePoints);
            self.verifyEqual(region.x, 0.5080)
            self.verifyEqual(region.y, 0.5194)
            self.verifyEqual(region.width, 0.5089 - 0.5080)
            self.verifyEqual(region.height, 0.5252 - 0.5194)
        end
        
        function videoRelativePoint(self)
            screen.pixels.width = 1600;
            screen.pixels.height = 900;
            video.pixels.width = 1920;
            video.pixels.height = 1080;
            video.scaling = 2/3;
            data.x = 0.45;
            data.y = 0.34;
            result = videoRelativePoint(screen, video, data);
            self.verifyEqual(result.x, ((0.45 - 0.5) * 1600 + 1920/2 * 2/3)/(1920 * 2/3));
            self.verifyEqual(result.y, ((0.34 - 0.5) * 900  + 1080/2 * 2/3)/(1080 * 2/3));
        end
    end
end