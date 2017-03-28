classdef AnyNumber < MockLab.Matchers.AnyMatcherBase
    %ANYSTRING Summary of this class goes here
    %   Detailed explanation goes here
    
   methods (Access = protected)
        function match = compareType(obj, arg)
            match = isnumeric(arg);
        end
    end 
    
    
end