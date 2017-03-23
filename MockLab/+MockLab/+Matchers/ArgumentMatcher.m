classdef (Abstract) ArgumentMatcher < handle
    % Interface to be implemented by any argument matchers used in stubbings. 
    %   Detailed explanation goes here
    
    methods (Abstract)
        matcherResult = match(obj, argList);
    end
    
end

