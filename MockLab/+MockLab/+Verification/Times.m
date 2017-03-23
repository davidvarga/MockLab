classdef Times < MockLab.Verification.VerificationMode
    %TIMES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = protected)
        WantedNumberOfInvocations;
    end
    
    methods(Access = protected)
        
        function evaluateInvocationResults(obj, numOfInvocations)
            if obj.WantedNumberOfInvocations ~= numOfInvocations
                error(['was called ', num2str(numOfInvocations), ' times, but wanted ', num2str(obj.WantedNumberOfInvocations), ' times.']);
            end
        end
        
    end
    
    methods
        function obj = Times(wantedNumberOfInvocations)
            obj.WantedNumberOfInvocations = wantedNumberOfInvocations;
        end
        
        function verify(obj, verificationData)

            mock = verificationData.getMock();
            argMatchers = verificationData.getArgumentMatcherList();
            
            if isempty(mock)
                error('Mock is empty');
            end
            
            invocations = mock.getInvocations();
            
            numOfInvocations = 0;
            for i = 1:numel(invocations)
                inv = invocations{i};
                
                if inv.verifyArgumentMatchers(verificationData.getMethodName(), argMatchers)
                    numOfInvocations = numOfInvocations + 1;
                end
            end
            
            
            obj.evaluateInvocationResults(numOfInvocations);
            
        end
        
    end
    
end


