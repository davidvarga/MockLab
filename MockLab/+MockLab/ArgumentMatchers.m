classdef ArgumentMatchers < handle
    %ARGUMENTMATCHERS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        
        function argMatcher = anyArgs()
            argMatcher = MockLab.Matchers.AnyArgs();
        end
        
        function argMatcher = anyCell()
            argMatcher = MockLab.Matchers.AnyCell();
        end
        
        function argMatcher = anyFloat()
            argMatcher = MockLab.Matchers.AnyFloat();
        end
        

        function argMatcher = anyInteger()
            argMatcher = MockLab.Matchers.AnyInteger();
        end
        
        function argMatcher = anyLogical()
            argMatcher = MockLab.Matchers.AnyLogical();
        end
        
        function argMatcher = anyNumber()
            argMatcher = MockLab.Matchers.AnyNumber();
        end
        
        function argMatcher = anyScalar()
            argMatcher = MockLab.Matchers.AnyScalar();
        end
        
        function argMatcher = anyString()
            argMatcher = MockLab.Matchers.AnyString();
        end
        
        function argMatcher = anyStruct()
            argMatcher = MockLab.Matchers.AnyStruct();
        end
        
        function argMatcher = argEqual(equalTo)
            argMatcher = MockLab.Matchers.ArgEqual(equalTo);
        end
        
        function argMatcher = any(varargin)
            % ToDo: Check nargin
            
            argMatcher = MockLab.Matchers.Any(varargin{:});
        end
        
    end
    
end

