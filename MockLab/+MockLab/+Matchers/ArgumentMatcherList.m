classdef ArgumentMatcherList < handle
    %ARGUMENTMATCHERLIST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        ArgumentMatchers = {};
    end
    
    methods
        
        function obj = ArgumentMatcherList(varargin)
           
            for i = 1:numel(varargin)
                if isa(varargin{i}, 'MockLab.Matchers.ArgumentMatcher')
                    % Use matcher
                    matcher = varargin{i};
                else
                    % Use constant matcher
                    matcher = MockLab.ArgumentMatchers.argEqual(varargin{i});
                end
                
                obj.ArgumentMatchers{end+1} = matcher;
            end
        end
        
        function argumentMatchers = getArgumentMatchers(obj)
            argumentMatchers = obj.ArgumentMatchers;
        end
        
    end
    
end

