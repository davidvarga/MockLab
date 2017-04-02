classdef Any < MockLab.Matchers.ArgumentMatcher
    %ANYSTRING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
       NeededType = ''; 
    end
    
    methods
        
        function obj = Any(varargin)
            if nargin > 0
                obj.NeededType = varargin{1};
            end
            
        end
        
        
        function matcherResult = match(obj, arguments)
            
            remArgs = arguments;
            if numel(arguments) < 1
                matcherResult = MockLab.Matchers.ArgumentMatcherResult(false, {});
            else
                if isempty(strtrim(obj.NeededType))
                    % Any without type
                    matches = true;
                else
                    matches = isa(arguments{1}, obj.NeededType);
                end

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