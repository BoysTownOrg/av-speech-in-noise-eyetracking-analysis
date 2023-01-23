classdef File < handle
    properties (Access = private)
        fid
    end

    methods
        function self = File(filepath)
            self.fid = fopen(filepath);
            if self.fid == -1
                error("cannot open file");
            end
        end

        function line = nextLine(self)
            line = fgetl(self.fid);
        end

        function delete(self)
            fclose(self.fid);
        end
    end
end