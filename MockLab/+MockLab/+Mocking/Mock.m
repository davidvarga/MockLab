classdef Mock < MockLab.Mocking.MockBase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = protected)
        MockedObj;
    end
    
    methods (Access = protected)
        function retCell = invokeNonMatching(obj, varargin)
            retCell = {};
        end
    end
    
    methods
        
         function mockedObj = getMockedObj(obj)
            mockedObj = obj.MockedObj;
        end
        
        function self = Mock(mockedObj)
            self@MockLab.Mocking.MockBase();
            
            if nargin == 0
                return;
                % ToDo: error
            end;
            
            if ~isobject(mockedObj)
                return;
                % ToDo: error
            end
            
            self.MockedObj = mockedObj;

        end

        
        function varargout = subsref(obj, S)
            
            % ToDo: pre-check
            
            if strcmp(S(1).subs, 'getMockedObj')
                varargout = {obj.getMockedObj()};
                return
            end
            
            if strcmp(S(1).subs, 'getInvocations')
                varargout = {obj.getInvocations()};
                return
            end
            
            if strcmp(S(1).subs, 'addStubbing')
                obj.addStubbing(S(2).subs{:});
                return
            end
            
            % If the predefined methods are not matching, it is an invocation
            invocationMatch = MockLab.Invocation.InvocationMatcher.match(S);
            if ~isempty(invocationMatch.getInvocation())
                obj.Invocations{end+1} = invocationMatch.getInvocation();
            end
            
            
            
            stubMatches = obj.match(invocationMatch.getInvocation());
            
            if numel(stubMatches) == 1
                stub = stubMatches{1};
                
                % Chained method call
                if ~isempty(invocationMatch.getRemainingInvocation)
                    builtin('subsref', stub.doReturn(invocationMatch.getInvocation().getArgumentList()), invocationMatch.getRemainingInvocation)
                else
                    varargout = stub.doReturn(invocationMatch.getInvocation().getArgumentList());
                end
            elseif numel(stubMatches) > 1
                error('Multiple match')
            else
                
                varargout = obj.invokeNonMatching(S);
            end
        end
    end
    
end

