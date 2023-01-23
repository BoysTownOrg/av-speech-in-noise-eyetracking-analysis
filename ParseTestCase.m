classdef ParseTestCase < matlab.unittest.TestCase
    methods (Test)
        function tbd(self)
            input = {
                'subject: DELETE';
                'tester: GD';
                'session: testing';
                'method: fixed-level free response predetermined stimuli eye tracking';
                'RME setting: -4';
                'transducer: 2 speakers';
                'masker: ~/Desktop/Factors_Study/L1L2_SSN-23.wav';
                'targets: Users/presentation/Desktop/Eye Tracking/settings/FamiliarizationList.txt';
                'masker level (dB SPL): 0';
                'SNR (dB): 65';
                'condition: audio-visual';
                '';
                'time, target, response';
                '2023-01-19 16:06:22, neutral_sent2_participant3.mp4, ';
                'target start time (ns): 301168722561609';
                'eye tracker time (us), target player time (ns)';
                '861298261401, 301168547794022';
                'eye tracker time (us), left gaze position relative screen [x y], right gaze position relative screen [x y], left gaze position relative tracker [x y z], right gaze position relative tracker [x y z], left gaze origin relative tracker [x y z], right gaze origin relative tracker [x y z]';
                '861297897884, nan nan, 0.457014 0.657486, nan nan nan, -21.9493 106.087 16, nan nan nan, -1.50641 -8.6518 629.279';
                '861297914537, nan nan, 0.47989 0.722465, nan nan nan, -9.82798 86.7198 16, nan nan nan, -1.49753 -8.63972 629.201';
                '861297931192, 0.444587 0.709378, 0.478074 0.684905, -28.5335 90.6204 16, -10.7899 97.9147 16, -61.7693 -8.97317 629.684, -0.651199 -8.47252 629.304';
                '861297947846, 0.448573 0.591044, 0.461864 0.547621, -26.4219 125.89 16, -19.3793 138.832 16, -61.5315 -8.93524 629.776, -0.823437 -8.54289 629.398';
                '861300779057, 0.51983 0.45608, 0.51271 0.480165, 11.3353 166.117 16, 7.56266 158.938 16, -61.1809 -9.71887 627.121, -2.09242 -9.5433 626.798';
                '861300795710, 0.51857 0.445129, 0.511007 0.475518, 10.6675 169.38 16, 6.6603 160.323 16, -61.2546 -9.70499 627.233, -2.14873 -9.52255 626.915';
                '2023-01-19 16:06:30, neutral_sent1_participant3.mp4, ';
                'target start time (ns): 301176775489506';
                'eye tracker time (us), target player time (ns)';
                '861306314052, 301176600724261';
                'eye tracker time (us), left gaze position relative screen [x y], right gaze position relative screen [x y], left gaze position relative tracker [x y z], right gaze position relative tracker [x y z], left gaze origin relative tracker [x y z], right gaze origin relative tracker [x y z]';
                '861305941850, 0.516777 0.499683, 0.524154 0.51581, 9.7175 153.12 16, 13.6263 148.314 16, -61.7311 -9.37858 625.768, -2.54882 -9.01512 625.489';
                '861305958505, 0.515612 0.508274, 0.520825 0.494911, 9.10004 150.56 16, 11.8623 154.543 16, -61.7374 -9.36655 625.719, -2.55763 -9.01221 625.441'
                };
            output = parseAvSpeechEyetrackingOutput(FileStub(input));
            self.verifyEqual(output.subject, "DELETE");
            self.verifyEqual(output.tester, "GD");
            self.verifyEqual(output.session, "testing");
            self.verifyEqual(output.method, "fixed-level free response predetermined stimuli eye tracking");
            self.verifyEqual(output.rmeSetting, "-4");
            self.verifyEqual(output.transducer, "2 speakers");
            self.verifyEqual(output.masker, "~/Desktop/Factors_Study/L1L2_SSN-23.wav");
            self.verifyEqual(output.targets, "Users/presentation/Desktop/Eye Tracking/settings/FamiliarizationList.txt");
            self.verifyEqual(output.maskerLevel_dB_SPL, 0);
            self.verifyEqual(output.trial(1).target, "neutral_sent2_participant3.mp4");
            self.verifyEqual(output.trial(1).eyetracking.targetStartTime_ns, sscanf('301168722561609', "%ld"));
            self.verifyEqual(output.trial(1).eyetracking.syncTime.eyeTracker_us, sscanf('861298261401', "%ld"));
            self.verifyEqual(output.trial(1).eyetracking.syncTime.targetPlayer_ns, sscanf('301168547794022', "%ld"));
            self.verifyEqual(output.trial(1).eyetracking.gaze(1).time_us, sscanf('861297897884', "%ld"));
            self.verifyEqual(output.trial(1).eyetracking.gaze(1).left.x, nan);
            self.verifyEqual(output.trial(1).eyetracking.gaze(1).left.y, nan);
            self.verifyEqual(output.trial(1).eyetracking.gaze(1).right.x, 0.457014);
            self.verifyEqual(output.trial(1).eyetracking.gaze(1).right.y, 0.657486);
            self.verifyEqual(output.trial(1).eyetracking.gaze(2).left.x, nan);
            self.verifyEqual(output.trial(1).eyetracking.gaze(2).left.y, nan);
            self.verifyEqual(output.trial(1).eyetracking.gaze(2).right.x, 0.47989);
            self.verifyEqual(output.trial(1).eyetracking.gaze(2).right.y, 0.722465);
            self.verifyEqual(output.trial(1).eyetracking.gaze(3).left.x, 0.444587);
            self.verifyEqual(output.trial(1).eyetracking.gaze(3).left.y, 0.709378);
            self.verifyEqual(output.trial(1).eyetracking.gaze(3).right.x, 0.478074);
            self.verifyEqual(output.trial(1).eyetracking.gaze(3).right.y, 0.684905);
            self.verifyEqual(output.trial(1).eyetracking.gaze(4).left.x, 0.448573);
            self.verifyEqual(output.trial(1).eyetracking.gaze(4).left.y, 0.591044);
            self.verifyEqual(output.trial(1).eyetracking.gaze(4).right.x, 0.461864);
            self.verifyEqual(output.trial(1).eyetracking.gaze(4).right.y, 0.547621);
            self.verifyEqual(output.trial(2).target, "neutral_sent1_participant3.mp4");
        end

        function tbd2(self)
            a.file = 'who.mp4';
            a.rectFace = [
                1, 2;
                3, 2;
                3, 4;
                1, 4;
                1, 2];
            b.file = 'what.mp4';
            b.rectFace = [
                11, 12;
                13, 12;
                13, 14;
                11, 14;
                11, 12];
            c.file = 'why.mp4';
            c.rectFace = [
                21, 22;
                23, 22;
                23, 24;
                21, 24;
                21, 22];
            video.pixels.height = 1080;
            video.pixels.width = 1920;
            map = convertToRoiMap({a, b, c}, video.pixels);
            whoRoi.x = 1/1920;
            whoRoi.y = 2/1080;
            whoRoi.width = (3 - 1) / 1920;
            whoRoi.height = (4 - 2) / 1080;
            self.verifyEqual(map('who.mp4'), whoRoi);
            whatRoi.x = 11/1920;
            whatRoi.y = 12/1080;
            whatRoi.width = (13 - 11) / 1920;
            whatRoi.height = (14 - 12) / 1080;
            self.verifyEqual(map('what.mp4'), whatRoi);
            whyRoi.x = 21/1920;
            whyRoi.y = 22/1080;
            whyRoi.width = (23 - 21) / 1920;
            whyRoi.height = (24 - 22) / 1080;
            self.verifyEqual(map('why.mp4'), whyRoi);
        end

        function tbd3(self)
            self.verifyEqual(convertToRoiMapKey('neutral_sent2_participant3.mp4'), 'neutral_sent2_participant3_av.mp4');
            self.verifyEqual(convertToRoiMapKey('neutral_sent9_participant3_av_repeat.mp4'), 'neutral_sent9_participant3_av.mp4');            
        end
    end
end