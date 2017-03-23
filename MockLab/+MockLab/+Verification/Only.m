classdef Only < MockLab.Verification.VerificationMode
    %TIMES Summary of this class goes here
    %   Detailed explanation goes here
    
    
    methods
        function obj = Only()
        end
        
        function verify(obj, verificationData)
            
            mock = verificationData.getMock();
            argMatchers = verificationData.getArgumentMatcherList();
            
            if isempty(mock)
                error('Mock is empty');
            end
            
            invocations = mock.getInvocations();
            
            otherInvocations = {};
            wasCalled = false;
            sameMethodDiffSignature = {};
            for i = 1:numel(invocations)
                inv = invocations{i};
                
                
                if ~inv.verifyArgumentMatchers(verificationData.getMethodName(), argMatchers)
                    if strcmp(verificationData.getMethodName(), inv.getMethodName())
                        % Same method but different signature
                        sameMethodDiffSignature{end+1} = inv;
                    else
                        otherInvocations{end+1} = inv;
                    end
                    
                else
                    wasCalled = true;
                    
                end
            end
            
            
            if ~wasCalled
                error('The method was not called with the given signature')
            else
                
                if ~isempty(sameMethodDiffSignature)
                    error('The method was called also with other signatures')
                end
                
                if ~isempty(otherInvocations)
                    error('Other method(s) were also called')
                end
                
            end
            
        end
        
    end
    
end


