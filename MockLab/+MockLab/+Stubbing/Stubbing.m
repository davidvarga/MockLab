classdef (Abstract) Stubbing < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = protected)
        ReturnMode;
        FunctionName;
        ArgumentMatcherList;
        Returns;
    end
    
    methods (Abstract)
        returnValue = doReturn(obj, arguments);
    end
    
    methods
        
        function retMode = getReturnMode(obj)
            retMode = obj.ReturnMode;
        end
        
        function ret = getReturnValue(obj)
            ret = obj.Returns;
        end
        
        function thenCallRealMethod(obj)
            obj.ReturnMode = MockLab.Stubbing.StubbingReturnMode.CALLREAL;
        end
        
        function thenReturn(obj, varargin)
            obj.ReturnMode = MockLab.Stubbing.StubbingReturnMode.RETURN;
            obj.Returns = varargin;
        end
     
        function answ = matches(obj, invocation)           
            answ = invocation.matchArgumentMatchers(obj.FunctionName, obj.ArgumentMatcherList);
        end
    end
    
end

