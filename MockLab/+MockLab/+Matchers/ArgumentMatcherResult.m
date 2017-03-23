classdef ArgumentMatcherResult < handle
    % MATCHRESULT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        UnmatchedArguments;
        Matched;
    end
    
    methods
        
        function obj = ArgumentMatcherResult(matched, unmatchedArgs)
            obj.Matched = matched;
            obj.UnmatchedArguments = unmatchedArgs;
        end
        
        function args = getUnmatchedArguments(obj)
            args = obj.UnmatchedArguments;
        end
        
        function matched = isMatched(obj)
            matched = obj.Matched;
        end
    end
    
end

