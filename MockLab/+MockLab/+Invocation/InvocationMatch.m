classdef InvocationMatch < handle
    %INCOVATIONMATCHRESULT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        Invocation = [];
        RemainingInvocation = [];
    end
    
    methods

        
        
        function obj = InvocationMatch(calledFunction, arguments, remainingInvocation)
            
            
            
            obj.Invocation = MockLab.Invocation.Invocation(calledFunction, arguments, now);
            
            obj.RemainingInvocation = remainingInvocation;
            
        end
        
        function invocation = getInvocation(obj)
            invocation = obj.Invocation;
        end
        
        function remainingInvocation = getRemainingInvocation(obj)
            remainingInvocation = obj.RemainingInvocation;
        end
        
        
    end
    
end

