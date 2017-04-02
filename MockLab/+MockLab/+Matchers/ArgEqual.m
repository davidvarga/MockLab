classdef ArgEqual < MockLab.Matchers.ArgumentMatcher
    %UNTITLED10 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        ArgumentValue;
    end
    
    methods
        
        function obj = ArgEqual(argumentValue)
            obj.ArgumentValue = argumentValue;
        end
        
        function matcherResult = match(obj, arguments)
            remArgs = arguments;
            if numel(arguments) < 1
                matcherResult = MockLab.Matchers.ArgumentMatcherResult(false, {});
            else
                matches = isequal(arguments{1}, obj.ArgumentValue);
                
                if matches
                    if numel(arguments) >= 2
                        remArgs = arguments(2:end);
                    else
                        remArgs = {};
                    end
                end
                
                matcherResult = MockLab.Matchers.ArgumentMatcherResult(matches, remArgs);
            end
        end
    end
    
end

