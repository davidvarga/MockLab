classdef VerificationData < handle
    %VERIFICATIONDATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        Mock;
        MethodName;
        ArgumentMatcherList;
    end
    
    methods
        function obj = VerificationData(mock, methodName, argumentMatcherList)
            obj.Mock = mock;
            obj.MethodName = methodName;
            obj.ArgumentMatcherList = argumentMatcherList;
        end
        
        function argumentMatcherList = getArgumentMatcherList(obj)
            argumentMatcherList = obj.ArgumentMatcherList;
        end
        
        function mock = getMock(obj)
            mock = obj.Mock;
        end
        
        function methodName = getMethodName(obj)
            methodName = obj.MethodName;
        end
        
        
    end
    
end


