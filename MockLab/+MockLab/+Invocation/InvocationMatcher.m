classdef InvocationMatcher < handle
    %INVOCATIONMATCHER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods(Static)
        function invMatch = match(callStruct)
            import MockLab.Invocation.*;
            
             if numel(callStruct) < 1 || ~strcmp(callStruct(1).type, '.')
               
               invMatch = InvocationMatch('', {}, callStruct);
               return;
             end
             
             if numel(callStruct) == 1 || (numel(callStruct) >= 2 && ~strcmp(callStruct(2).type, '()'))
                 % E.g. mock.mockedFunction.otherFunction
                 newCallStruct(1) = callStruct(1);
                 newCallStruct(2) = substruct('()', {});
                 
                 for i = 2 : numel(callStruct)
                     newCallStruct(i+1) = callStruct(i);
                 end
                 
                 callStruct = newCallStruct;
             end
            
             % The call struct is at least 2 long, and the first two element is a function call with arguments
             fcnName = callStruct(1).subs;
             args = callStruct(2).subs;
             

           
            
             if numel(callStruct) > 2
               remaining = callStruct(3:end);
             else
                 remaining = [];
               
             end
            
             invMatch = InvocationMatch(fcnName, args, remaining);
                
          
        end
    end
    
end

