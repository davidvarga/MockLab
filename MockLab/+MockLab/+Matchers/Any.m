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
        
        
        function matcherResult = match(obj, args)
            
            if isempty(args)
                matcherResult = MockLab.Matchers.ArgumentMatcherResult(false, {});
                return;
            end
            remArgs = {};
            if numel(args) > 1
                remArgs = args(2:end);
            end
            
            if isempty(strtrim(obj.NeededType))
                % Any without type
                matcherResult = MockLab.Matchers.ArgumentMatcherResult(true, remArgs);
            else
                matcherResult = MockLab.Matchers.ArgumentMatcherResult(isa(args{1}, obj.NeededType), remArgs);
            end
        end
    end
    
end