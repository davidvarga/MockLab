classdef AnyMatcherBase < MockLab.Matchers.ArgumentMatcher
    %ANYMATCHERBASE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Abstract, Access = protected)
        matching = compareType(obj, arg);
        
    end
    
    methods
       function matcherResult = match(obj, args)
            narg = numel(args);
            remArgs = args;
            
            if narg >= 1
                match = obj.compareType(args{1});
                if match
                    if narg >= 2
                        remArgs = args(2:end);
                    else
                        remArgs = {};
                    end
                end
                matcherResult = MockLab.Matchers.ArgumentMatcherResult(match, remArgs);   
            else
                matcherResult = MockLab.Matchers.ArgumentMatcherResult(false, remArgs);
            end 
        end 
    end
    
end

