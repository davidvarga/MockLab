classdef AnyArgs < MockLab.Matchers.ArgumentMatcher
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    % ToDo: its greedy
    methods
   

        function matcherResult = match(obj, args)
            matcherResult = MockLab.Matchers.ArgumentMatcherResult(true, {});
        end
    end
end

