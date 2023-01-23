classdef FileStub < handle
    properties
        lineNumber
        lines
    end

    methods
        function self = FileStub(lines)
            self.lineNumber = 1;
            self.lines = lines;
        end

        function line = nextLine(self)
            if self.lineNumber <= numel(self.lines)
                line = self.lines{self.lineNumber};
                self.lineNumber = self.lineNumber + 1;
            else
                line = -1;
            end
        end
    end
end