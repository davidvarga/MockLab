classdef VerificationModes < handle
    %VERIFICATIONMODEFACTORY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        
        function verificationMode = only()
            verificationMode = MockLab.Verification.Only();
        end
        
        function verificationMode = times(wantedNumberOfInvocation)
            verificationMode = MockLab.Verification.Times(wantedNumberOfInvocation);
        end
        
        function verificationMode = atLeast(minimalNumberOfInvocation)
            verificationMode = MockLab.Verification.AtLeast(minimalNumberOfInvocation);
        end
        
        function verificationMode = atLeastOnce()
            verificationMode = MockLab.Verification.AtLeast(1);
        end
        
        function verificationMode = atMost(maximalNumberOfInvocation)
            verificationMode = MockLab.Verification.AtMost(maximalNumberOfInvocation);
        end
        
        function verificationMode = noMore()
            verificationMode = MockLab.Verification.NoMore();
        end
        
        function verificationMode = zeroInteraction()
            verificationMode = MockLab.Verification.ZeroInteraction();
        end
        
    end
    
end