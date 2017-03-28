classdef AnyMatrix < MockLab.Matchers.AnyMatcherBase
    %ANYSTRING Summary of this class goes here
    %   Detailed explanation goes here
    
   methods (Access = protected)
        function match = compareType(obj, arg)
            match = ismatrix(arg);
        end
    end 
    
end