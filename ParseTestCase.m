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
                -1
                };
                output = parseAvSpeechEyetrackingOutput(FileStub(input));
                self.verifyEqual(output.subject, "DELETE");
        end
    end
end