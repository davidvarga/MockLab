classdef AtLeast < MockLab.Verification.Times
    %TIMES Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Access = protected)
        
        function evaluateInvocationResults(obj, numOfInvocations)
            if obj.WantedNumberOfInvocations > numOfInvocations
                error(['was called ', num2str(numOfInvocations) ' times, but wanted ', num2str(obj.WantedNumberOfInvocations), ' times.']);
            end
        end
    end
    
    methods
        function obj = AtLeast(minimalNumberOfIncvocations)
            obj = obj@MockLab.Verification.Times(minimalNumberOfIncvocations);
        end
    end
end

