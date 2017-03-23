classdef MethodStubbing < MockLab.Stubbing.Stubbing
    %METHODSTUBBING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        MockedObject;
    end
    
    methods
        function self = MethodStubbing(mockedObject, fcnName, argumentMatcherList)
            self.FunctionName = fcnName;
            self.ArgumentMatcherList = argumentMatcherList;
            self.MockedObject = mockedObject;
        end
        
        function returnValue = doReturn(obj, arguments)
            if obj.ReturnMode == MockLab.Stubbing.StubbingReturnMode.RETURN
                returnValue = obj.Returns;
            elseif obj.ReturnMode == MockLab.Stubbing.StubbingReturnMode.CALLREAL

                
                callStruct = substruct('.', obj.FunctionName, '()', arguments);
                returnValue = {subsref(obj.MockedObject, callStruct)};
            end
            
        end
        
    end
    
end

