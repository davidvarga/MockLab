classdef Mockery
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    
    methods
        
        function mockObj = mock(obj, mockedObj)
            mockObj = MockLab.Mocking.Mock(mockedObj);
        end
        
        function mockObj = spy(obj, mockedObj)
            mockObj = MockLab.Mocking.Spy(mockedObj);
        end
        
        function stubbing = when(obj, mock, fnName, varargin)
            
            import MockLab.*;
            import MockLab.Matchers.*;
            import MockLab.Stubbing.*;
            
            mockableMethods = methods(mock.getMockedObj());
            if ~any(strcmp(fnName, mockableMethods))
                error(['Cannot mock method "', fnName, '".'])
            end
            
            stubbing = MethodStubbing(mock.getMockedObj(), fnName, MockLab.Matchers.ArgumentMatcherList(varargin{:}));
            mock.addStubbing(stubbing)
        end
        
        function verify(obj, mock, functionName, varargin)
            
            if numel(varargin) && isa(varargin{1}, 'MockLab.Verification.VerificationMode')
                verificationMode = varargin{1};
                argMatcherList = varargin(2:end);
                
            else
                verificationMode = MockLab.VerificationModes.times(1);
                argMatcherList = varargin;
            end
            verificationData = MockLab.Verification.VerificationData(mock, functionName, MockLab.Matchers.ArgumentMatcherList(argMatcherList{:}));
            verificationMode.verify(verificationData);
        end
        
        function verifyZeroInteractions(obj, varargin)
            for i = 1:numel(varargin)
                obj.verify(varargin{i}, '', MockLab.VerificationModes.zeroInteraction(), MockLab.Matchers.AnyArgs());
            end
        end
        
        function verifyNoMoreInteractions(obj, varargin)
            for i = 1:numel(varargin)
                obj.verify(varargin{i}, '', MockLab.VerificationModes.noMore());
            end
        end
    end
    
end


