classdef AnyCell < MockLab.Matchers.AnyMatcherBase
    %ANYSTRING Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Access = protected)
        function match = compareType(obj, arg)
            match = iscell(arg);
        end
    end 
end