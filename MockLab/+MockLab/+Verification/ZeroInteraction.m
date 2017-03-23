classdef ZeroInteraction < MockLab.Verification.VerificationMode
    %TIMES Summary of this class goes here
    %   Detailed explanation goes here
    
    
    methods
        function obj = ZeroInteraction()
            
        end
        
        function verify(obj, verificationData)
            
            mock = verificationData.getMock();
            
            if isempty(mock)
                error('Mock is empty');
            end
            
            
            invocations = mock.getInvocations();
            otherInvocations = {};
            
            for i = 1:numel(invocations)
                inv = invocations{i};
                otherInvocations{end+1} = inv;
            end
            
            
            if ~isempty(otherInvocations)
                error('There were some interaction')
            end
            
        end
        
    end
    
end


