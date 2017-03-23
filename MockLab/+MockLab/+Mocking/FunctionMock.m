classdef FunctionMock < MockLab.Mocking.MockBase
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        MockedFunction;
        MockingDirectory;
    end
    
    methods
        
        function self = FunctionMock(mockedFunction, mockingDirectory)
            self@MockLab.Mocking.MockBase();
            
            if nargin == 0
                return;
                % ToDo: error
            end;
            
            self.MockedFunction = mockedFunction;
            self.MockingDirectory = mockingDirectory;
            self.addToPath();
            
        end
        
        function mockedFunction = getMockedFunction(obj)
            mockedFunction = obj.MockedFunction;
        end
        
        function addToPath(obj)
            addpath(obj.MockingDirectory);
        end
        
        function removeFromPath(obj)
            rmpath(obj.MockingDirectory);
            
        end
        
        
        function retCell = call(obj, args)
            
            % Create an Invoctaion
            invocationMatch = MockLab.Invocation.InvocationMatcher.match(substruct('.', obj.MockedFunction, '()', args));
            if ~isempty(invocationMatch.getInvocation())
                obj.Invocations{end+1} = invocationMatch.getInvocation();
            end
            
            stubMatches = match(obj, invocationMatch.getInvocation());
            
            if numel(stubMatches) == 1
                stub = stubMatches{1};
                retMode = stub.getReturnMode();
                
                if retMode == MockLab.Stubbing.StubbingReturnMode.RETURN
                    retCell = stub.getReturnValue();
                elseif retMode == MockLab.Stubbing.StubbingReturnMode.CALLREAL
                    % The function mock should be removed from the path
                    % The original function should be called
                    % The function mock should be added to the path again
                    retCell = obj.callRealFunction(invocationMatch.getInvocation());
                    
                end               
            elseif numel(stubMatches) > 1
                error('multiple stubbing amtch')
            else

                retCell = {};
            end
        end
    end
    
    methods (Access = private)
        function retCell = callRealFunction(obj, invocation)
            obj.removeFromPath();
            arguments = invocation.getArgumentList();
            %                 callStruct = substruct('.', obj.FunctionName, '()', arguments);
            retCell = {eval([obj.getMockedFunction(), '(arguments{:})'])};
            obj.addToPath();
        end
    end
    
end

