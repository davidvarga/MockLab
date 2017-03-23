classdef Spy < MockLab.Mocking.Mock
    %SPY Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Access = protected)
        function retCell = invokeNonMatching(obj, S)
            retCell = {builtin('subsref', obj.MockedObj, S)};
            
        end
    end
    
    methods
        function self = Spy(mockedObj)
            self@MockLab.Mocking.Mock(mockedObj);
        end
    end
    
    
end

