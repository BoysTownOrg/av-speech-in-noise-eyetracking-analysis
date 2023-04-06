classdef GazeAnalysisTestCase < matlab.unittest.TestCase
    methods(Test)
        function targetStartRelativeTime_ms(self)
            trial.targetStartTime_ns = 335843231518711;
            trial.syncTime.eyeTracker_us = 1208315441434;
            trial.syncTime.targetPlayer_ns = 335843075631090;
            self.verifyEqual(...
                aspl.targetStartRelativeTime_ms(trial, 1208316167880), ...
                (...
                (1208316167880 - 1208315441434)*1000 + ...
                335843075631090 - ...
                335843231518711)/1e6...
                );
        end

        function targetStartRelativeTime_ns(self)
            trial.targetStartTime_ns = 335843231518711;
            trial.syncTime.eyeTracker_us = 1208315441434;
            trial.syncTime.targetPlayer_ns = 335843075631090;
            self.verifyEqual(...
                aspl.targetStartRelativeTime_ns(trial, 1208316167880), ...
                (1208316167880 - 1208315441434)*1000 + ...
                335843075631090 - 335843231518711 ...
                );
        end

        function gazeDuration_ms(self)
            gaze(1).time_us = 1208316167880;
            gaze(2).time_us = 1208316184536;
            gaze(3).time_us = 1208316201191;
            self.verifyEqual(aspl.gazeDuration_ms(gaze), (1208316201191 - 1208316167880)/1000);
        end

        function gazeDuration_us(self)
            gaze(1).time_us = 1208316167880;
            gaze(2).time_us = 1208316184536;
            gaze(3).time_us = 1208316201191;
            self.verifyEqual(aspl.gazeDuration_us(gaze), 1208316201191 - 1208316167880);
        end

        function videoRelativePoint(self)
            screen.pixels.width = 1600;
            screen.pixels.height = 900;
            video.pixels.width = 1920;
            video.pixels.height = 1080;
            video.scaling = 2/3;
            screenRelativePoint.x = 0.45;
            screenRelativePoint.y = 0.34;
            result = aspl.videoRelativePoint(screen, video, screenRelativePoint);
            self.verifyEqual(result.x, (0.45 - 0.5) * 1600/1920/(2/3) + 0.5);
            self.verifyEqual(result.y, (0.34 - 0.5) * 900/1080/(2/3) + 0.5);
        end

        function screenRelativePoint(self)
            screen.pixels.width = 1600;
            screen.pixels.height = 900;
            video.pixels.width = 1920;
            video.pixels.height = 1080;
            video.scaling = 2/3;
            videoRelativePoint.x = 0.45;
            videoRelativePoint.y = 0.34;
            result = aspl.screenRelativePoint(screen, video, videoRelativePoint);
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
            result = aspl.screenRelativeRegion(screen, video, videoRelativeRegion);
            self.verifyEqual(result.x, 1920 * 2/3 * (0.45 - 0.5)/1600 + 0.5);
            self.verifyEqual(result.y, 1080 * 2/3 * (0.34 - 0.5)/900  + 0.5);
            self.verifyEqual(result.width,  0.03 * (2/3) * 1920/1600);
            self.verifyEqual(result.height,  0.11 * (2/3) * 1080/900);
        end

        function firstGazeWithinRegion(self)
            points(1).x = 0.48;
            points(1).y = 0.45;
            points(2).x = 0.51;
            points(2).y = 0.53;
            points(3).x = 0.51;
            points(3).y = 0.52;
            region.x = 0.48;
            region.y = 0.46;
            region.width = 0.03;
            region.height = 0.07;
            self.verifyEqual(aspl.firstGazeWithinRegion(points, region), 2);
        end

        function regionContains(self)
            region.x = 0.2;
            region.y = 0.3;
            region.width = 0.04;
            region.height = 0.05;
            point.x = 0.2;
            point.y = 0.3;
            self.verifyTrue(aspl.regionContains(region, point));
            point.x = 0.1;
            point.y = 0.2;
            self.verifyFalse(aspl.regionContains(region, point));
            point.x = 0.24;
            point.y = 0.35;
            self.verifyTrue(aspl.regionContains(region, point));
            point.x = 0.23;
            point.y = 0.2;
            self.verifyFalse(aspl.regionContains(region, point));
            point.x = 0.1;
            point.y = 0.34;
            self.verifyFalse(aspl.regionContains(region, point));
            point.x = 0.22;
            point.y = 0.33;
            self.verifyTrue(aspl.regionContains(region, point));
        end

        function fixations1(self)
            gaze(1).time_us = 123000;
            gaze(1).left.x = 0.1;
            gaze(1).left.y = 0.1;
            gaze(2).time_us = 124000;
            gaze(2).left.x = 0.8;
            gaze(2).left.y = 0.8;
            gaze(3).time_us = 126000;
            gaze(3).left.x = 0.8;
            gaze(3).left.y = 0.8;
            gaze(4).time_us = 129000;
            gaze(4).left.x = 0.8;
            gaze(4).left.y = 0.1;
            gaze(5).time_us = 133000;
            gaze(5).left.x = 0.8;
            gaze(5).left.y = 0.8;
            gaze(6).time_us = 138000;
            gaze(6).left.x = 0.8;
            gaze(6).left.y = 0.8;
            gaze(7).time_us = 145000;
            gaze(7).left.x = 0.1;
            gaze(7).left.y = 0.1;
            gaze(8).time_us = 147000;
            gaze(8).left.x = 0.8;
            gaze(8).left.y = 0.8;
            roi.x = 0.7;
            roi.y = 0.7;
            roi.width = 0.2;
            roi.height = 0.2;
            threshold_us = 2000;
            fixations = aspl.findFixations(gaze, roi, threshold_us);
            self.verifyEqual(numel(fixations.left), 2);
            self.verifyEqual(fixations.left(1).duration_ms, 126 - 124);
            self.verifyEqual(fixations.left(1).firstGazeIndex, 2);
            self.verifyEqual(fixations.left(2).duration_ms, 138 - 133);
            self.verifyEqual(fixations.left(2).firstGazeIndex, 5);
        end

        function fixations2(self)
            gaze(1).time_us = 123000;
            gaze(1).left.x = 0.8;
            gaze(1).left.y = 0.8;
            gaze(2).time_us = 124000;
            gaze(2).left.x = 0.8;
            gaze(2).left.y = 0.8;
            gaze(3).time_us = 126000;
            gaze(3).left.x = 0.8;
            gaze(3).left.y = 0.8;
            gaze(4).time_us = 129000;
            gaze(4).left.x = 0.8;
            gaze(4).left.y = 0.1;
            gaze(5).time_us = 133000;
            gaze(5).left.x = 0.8;
            gaze(5).left.y = 0.8;
            gaze(6).time_us = 138000;
            gaze(6).left.x = 0.8;
            gaze(6).left.y = 0.8;
            gaze(7).time_us = 145000;
            gaze(7).left.x = 0.8;
            gaze(7).left.y = 0.8;
            gaze(8).time_us = 147000;
            gaze(8).left.x = 0.8;
            gaze(8).left.y = 0.8;
            roi.x = 0.7;
            roi.y = 0.7;
            roi.width = 0.2;
            roi.height = 0.2;
            threshold_us = 2000;
            fixations = aspl.findFixations(gaze, roi, threshold_us);
            self.verifyEqual(numel(fixations.left), 2);
            self.verifyEqual(fixations.left(1).duration_ms, 126 - 123);
            self.verifyEqual(fixations.left(2).duration_ms, 147 - 133);
        end

        function fixations3(self)
            gaze(1).time_us = 12300;
            gaze(1).left.x = 0.8;
            gaze(1).left.y = 0.8;
            gaze(2).time_us = 12400;
            gaze(2).left.x = 0.8;
            gaze(2).left.y = 0.8;
            gaze(3).time_us = 12600;
            gaze(3).left.x = 0.8;
            gaze(3).left.y = 0.8;
            gaze(4).time_us = 12900;
            gaze(4).left.x = 0.8;
            gaze(4).left.y = 0.1;
            gaze(5).time_us = 13300;
            gaze(5).left.x = 0.8;
            gaze(5).left.y = 0.8;
            gaze(6).time_us = 13800;
            gaze(6).left.x = 0.8;
            gaze(6).left.y = 0.8;
            gaze(7).time_us = 14500;
            gaze(7).left.x = 0.8;
            gaze(7).left.y = 0.8;
            gaze(8).time_us = 14700;
            gaze(8).left.x = 0.8;
            gaze(8).left.y = 0.8;
            roi.x = 0.7;
            roi.y = 0.7;
            roi.width = 0.2;
            roi.height = 0.2;
            threshold_us = 2000;
            fixations = aspl.findFixations(gaze, roi, threshold_us);
            self.verifyTrue(isempty(fixations.left));
        end

        function fixations4(self)
            gaze(1).time_us = 123000;
            gaze(1).right.x = 0.8;
            gaze(1).right.y = 0.8;
            gaze(2).time_us = 124000;
            gaze(2).right.x = 0.8;
            gaze(2).right.y = 0.8;
            gaze(3).time_us = 126000;
            gaze(3).right.x = 0.8;
            gaze(3).right.y = 0.8;
            gaze(4).time_us = 129000;
            gaze(4).right.x = 0.8;
            gaze(4).right.y = 0.8;
            gaze(5).time_us = 133000;
            gaze(5).right.x = 0.8;
            gaze(5).right.y = 0.8;
            gaze(6).time_us = 138000;
            gaze(6).right.x = 0.8;
            gaze(6).right.y = 0.1;
            gaze(7).time_us = 145000;
            gaze(7).right.x = 0.8;
            gaze(7).right.y = 0.8;
            gaze(8).time_us = 147000;
            gaze(8).right.x = 0.8;
            gaze(8).right.y = 0.8;
            roi.x = 0.7;
            roi.y = 0.7;
            roi.width = 0.2;
            roi.height = 0.2;
            threshold_us = 2000;
            fixations = aspl.findFixations(gaze, roi, threshold_us);
            self.verifyEqual(numel(fixations.right), 2);
            self.verifyEqual(fixations.right(1).duration_ms, 133 - 123);
            self.verifyEqual(fixations.right(2).duration_ms, 147 - 145);
        end

        function videoRelativeNormalizedRegionFace(self)
            fileInfo.rectFace = [
                798    160
                1200    160
                1200    686
                798    686
                798    160];
            videoPixels.height = 1080;
            videoPixels.width = 1920;
            region = aspl.videoRelativeNormalizedRegionFace(fileInfo, videoPixels);
            self.assertEqual(region.x, 798 / 1920);
            self.assertEqual(region.y, 160 / 1080);
            self.assertEqual(region.width, (1200 - 798) / 1920);
            self.assertEqual(region.height, (686 - 160) / 1080);
        end

        function videoRelativeNormalizedRegionUpperFace(self)
            fileInfo.rectFace = [
                798    160
                1200    160
                1200    686
                798    686
                798    160];
            fileInfo.bisect = 423;
            videoPixels.height = 1080;
            videoPixels.width = 1920;
            region = aspl.videoRelativeNormalizedRegionUpperFace(fileInfo, videoPixels);
            self.assertEqual(region.x, 798 / 1920);
            self.assertEqual(region.y, 160 / 1080);
            self.assertEqual(region.width, (1200 - 798) / 1920);
            self.assertEqual(region.height, (423 - 160) / 1080);
        end
    end
end