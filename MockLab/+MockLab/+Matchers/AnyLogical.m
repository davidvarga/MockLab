classdef AnyLogical < MockLab.Matchers.AnyMatcherBase
    %ANYSTRING Summary of this class goes here
    %   Detailed explanation goes here
    
   methods (Access = protected)
        function match = compareType(obj, arg)
            match = islogical(arg);
        end
    end 
    
end