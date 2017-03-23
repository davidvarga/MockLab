classdef FunctionStubbing < MockLab.Stubbing.Stubbing
    %FUNCTIONSTUBBING Summary of this class goes here
    %   Detailed explanation goes here
    
 properties (Access = private)
     Mock;
    end
    
    methods
        function self = FunctionStubbing(functionMock, argumentMatcherList)
            self.Mock = functionMock;
            self.ArgumentMatcherList = argumentMatcherList;
            self.FunctionName = self.Mock.getMockedFunction();
        end
        
        function returnValue = doReturn(obj, arguments)
            if obj.ReturnMode == MockLab.Stubbing.StubbingReturnMode.RETURN
                returnValue = obj.Returns;
            elseif obj.ReturnMode == MockLab.Stubbing.StubbingReturnMode.CALLREAL
               % The function mock should be removed from the path
                % The original function should be called
                % The function mock should be added to the path again
                
                obj.Mock.removeFromPath();
                
%                 callStruct = substruct('.', obj.FunctionName, '()', arguments);
                returnValue = {eval([obj.Mock.getMockedFunction(), '(arguments{:})'])};
                obj.Mock.addToPath();
            end
            
        end
        
    end
end

