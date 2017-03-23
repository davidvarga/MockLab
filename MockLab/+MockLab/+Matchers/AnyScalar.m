classdef AnyScalar < MockLab.Matchers.ArgumentMatcher
    %ANYSTRING Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        
        
        function matcherResult = match(obj, args)
            
            if numel(args) >= 1
                if numel(args) >= 2
                    remArgs = args(2:end);
                else
                    remArgs = {};
                end
                
                matcherResult = MockLab.Matchers.ArgumentMatcherResult(isscalar(args{1}), remArgs);
                
            else
                matcherResult = MockLab.Matchers.ArgumentMatcherResult(false, {});
            end
            
            
        end
    end
    
end