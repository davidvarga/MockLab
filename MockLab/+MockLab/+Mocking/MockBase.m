classdef MockBase < handle
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = protected)
        
        Stubbings = {};
        Invocations = {};
    end
    
    methods
        
        function obj = MockBase()
            
        end
        
        function addStubbing(obj, stubbing)
            
            obj.Stubbings{end+1} = stubbing;
        end
        
        function stubMatches = match(obj, invocation)
            import MockLab.Stubbing.*;
            
            stubMatches = {};
            
            for i = 1:numel(obj.Stubbings)
                stub = obj.Stubbings{i};
                %stubMatch = stub.match(invocation);
                
                if stub.matches(invocation)
                    stubMatches{end+1} = stub;
                end
                
            end
        end
        
        function invocations = getInvocations(obj)
            invocations = obj.Invocations;
        end

        
    end
    
end

