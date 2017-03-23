classdef NoMore < MockLab.Verification.VerificationMode
    %TIMES Summary of this class goes here
    %   Detailed explanation goes here
    
    
    methods   
        function obj = NoMore()
        
        end
 
        function verify(obj, verificationData)
            
            mock = verificationData.getMock();
            
            
            if isempty(mock)
                error('Mock is empty');
            end
            
            invocations = mock.getInvocations();
            
            noMoreInteractions = true;
            for i = 1:numel(invocations)
                
                if ~invocations{i}.isVerified()
                    noMoreInteractions = false;
                    break;
                end
            end
            
            if ~noMoreInteractions
                error('There were some other interactions');
            end
            
        end
        
    end
    
end


