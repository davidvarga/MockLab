classdef AtMost < MockLab.Verification.Times
    %TIMES Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Access = protected)
        
        function evaluateInvocationResults(obj, numOfInvocations)
            if  numOfInvocations > obj.WantedNumberOfInvocations
                error(['was called ', num2str(numOfInvocations) ' times, but wanted max ', num2str(obj.WantedNumberOfInvocations), ' times.']);
            end
        end 
    end
    
    methods
        function obj = AtMost(maximalNumberOfIncvocations)
            obj = obj@MockLab.Verification.Times(maximalNumberOfIncvocations);
            
        end
    end
end

