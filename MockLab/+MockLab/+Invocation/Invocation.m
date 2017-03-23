classdef Invocation < handle
    %INVOCATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        MethodName;
        ArgumentList;
        TimeStamp;
        Verified = false;
        
    end
    
    methods
        
        function obj = Invocation(methodName, argumentList, timeStamp)
            obj.MethodName = methodName;
            obj.ArgumentList = argumentList;
            obj.TimeStamp = timeStamp;
        end
        
        function methodName = getMethodName(obj)
            methodName = obj.MethodName;
        end
        
        function argumentList = getArgumentList(obj)
            argumentList = obj.ArgumentList;
        end
        
        function timeStamp = getTimeStamp(obj)
            timeStamp = obj.TimeStamp;
        end
        
        function answ = verifyArgumentMatchers(obj, methodName, argumentMatcherList)
            answ = obj.matchArgumentMatchers(methodName, argumentMatcherList);
            if answ
                obj.Verified = true;
            end
        end
        
        function answ = matchArgumentMatchers(obj, methodName, argumentMatcherList)
            if ~strcmp(obj.getMethodName(), methodName)
                answ = false;
                return;
            end
            
            answ = true;
            args = obj.getArgumentList();
            argumentMatchers = argumentMatcherList.getArgumentMatchers();
            for iMatcher = 1:numel(argumentMatchers)
                
                matchResult = argumentMatchers{iMatcher}.match(args);
                if ~matchResult.isMatched()
                    answ = false;
                    break;
                else
                    args = matchResult.getUnmatchedArguments();
                end
            end
            
            answ = answ && isempty(args);    
        end
        
        function verified = isVerified(obj)
            verified = obj.Verified;
        end
        
        
    end
    
end

