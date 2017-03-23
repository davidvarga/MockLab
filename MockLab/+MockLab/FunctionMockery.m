classdef FunctionMockery < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        FunctionMocks = {};
    end
    
    properties(Access = private, Constant)
        ROOT_DIR_NAME = ['com', filesep(), 'github', filesep(), 'davidvarga', filesep(), 'mocklab', filesep(), 'functionMockery'];
        APPDATA_NAME = 'com_github_davidvarga_mocklab_functionmockery';
    end
    
    methods(Access = private)
        function obj = FunctionMockery(functionMocks)
            import MockLab.FunctionMockery;
            
            if nargin < 1 || isempty(functionMocks)
                obj.FunctionMocks = {};
                FunctionMockery.createTempDirectory();
                
                FunctionMockery.setAppDataInstance(obj.FunctionMocks);
            else
                obj.FunctionMocks = functionMocks;
            end
        end
    end
    
    methods(Static)
        function singleObj = getInstance()
            import MockLab.*;
            
            
            if ~FunctionMockery.isAppDataValid()
                singleObj = FunctionMockery();
            else
                singleObj = FunctionMockery(FunctionMockery.getAppDataInstace());
            end
        end
        
        function directory = getDirectory()
            directory = fullfile(tempdir(), MockLab.FunctionMockery.ROOT_DIR_NAME);
        end
    end
    
    methods(Static = true, Access = private)
        function valid = isAppDataValid()
            valid = ~isempty(MockLab.FunctionMockery.getAppDataInstace());
        end
        
        function instance = getAppDataInstace()
            instance = getappdata(0, MockLab.FunctionMockery.APPDATA_NAME);
        end
        
        function setAppDataInstance(instance)
            setappdata(0, MockLab.FunctionMockery.APPDATA_NAME, instance);
        end
        
        function createTempDirectory()
            tempDir = MockLab.FunctionMockery.getDirectory();
            if exist(tempDir, 'dir')
                rmdir(tempDir, 's');
            end
            
            mkdir(tempDir);
        end
    end
    
    methods
        
        function fcnMock = getFuncionMockByName(obj, functionName)
            fcnMock = [];
            for i = 1:numel(obj.FunctionMocks)
                fMock = obj.FunctionMocks{i};
                if strcmp(fMock.getMockedFunction, functionName)
                    fcnMock = fMock;
                    break;
                end
            end
        end
        
        function stubbing = when(obj, fcnMock, varargin)
            import MockLab.*;
            import MockLab.Matchers.*;
            import MockLab.Stubbing.*;
            
            % ToDo: fcnNomck can be FcnMock or the name of the function
            if isa(fcnMock, 'MockLab.Mocking.FunctionMock')
                fnName = getMockedFunction.getMockedFunction();
            elseif ischar(fcnMock)
                fnName = fcnMock;
            else
                error('asdasd')
            end
            
            fcnMock = obj.mock(fnName);
            
            stubbing = FunctionStubbing(fcnMock, MockLab.Matchers.ArgumentMatcherList(varargin{:}));
            fcnMock.addStubbing(stubbing)
            
        end
        
        function verify(obj, mockName, varargin)
            % vararg{1} == VerificationMode
            
            % ToDo: Check arguments
            
            mock = [];
            % Get the mock of the invocation
            for i = 1:numel(obj.FunctionMocks)
                fcnMock = obj.FunctionMocks{i};
                
                if strcmp(fcnMock.getMockedFunction(), mockName)
                    mock = fcnMock;
                    break;
                end
            end
            
            if isempty(mock)
                error('Verification failed');
            end
            
            if isa(varargin{1}, 'MockLab.Verification.VerificationMode')
                verificationMode = varargin{1};
                argMatcherList = varargin(2:end);
                
            else
                verificationMode = MockLab.VerificationModes.times(1);
                argMatcherList = varargin;
                % ToDo: Times 1;
                
                
            end
            verificationData = MockLab.Verification.VerificationData(mock, mockName, MockLab.Matchers.ArgumentMatcherList(argMatcherList{:}));
            verificationMode.verify(verificationData);
            
            
        end
        
        function verifyZeroInteractions(obj, functionNames)
            if ~iscell(functionNames)
                functionNames = {functionNames};
            end
            
            for i = 1:numel(functionNames)
                obj.verify(functionNames{i}, MockLab.VerificationModes.zeroInteraction(), MockLab.Matchers.AnyArgs());
            end
            
        end
        
        function verifyNoMoreInteractions(obj, functionNames)
            
            if ~iscell(functionNames)
                functionNames = {functionNames};
            end
            
            for i = 1:numel(functionNames)
                obj.verify(functionNames{i}, MockLab.Verification.VerificationModeFactory.noMore());
            end
            
        end
        
        function delete(obj)
            if ~getappdata(0, [MockLab.FunctionMockery.APPDATA_NAME, '_do_notclear'])
                MockLab.FunctionMockery.setAppDataInstance([]);
                warning('off', 'MATLAB:rmpath:DirNotFound');
                rmpath(genpath(obj.getDirectory()));
                warning('on', 'MATLAB:rmpath:DirNotFound');
                rmdir(obj.getDirectory(), 's');
                
            end
            setappdata(0, [MockLab.FunctionMockery.APPDATA_NAME, '_do_notclear'], 0);
        end
        
    end
    methods(Access = private)
        function fcnMock = mock(obj, functionName)
            % Creates a function mock for the given function.
            
            import MockLab.*;
            import MockLab.Mocking.*;
            
            functionName = strtrim(functionName);
            
            % Create a subdirectory for the function
            fcnMockDir = fullfile(FunctionMockery.getDirectory(), functionName);
            if ~exist(fcnMockDir, 'dir')
                mkdir(fcnMockDir);
                
            end
            
            mockFile = fullfile(fcnMockDir, [functionName, '.m']);
            
            if ~exist(mockFile, 'file')
                
                strGetFunctionMockery = 'mockery = MockLab.FunctionMockery.getInstance();';
                
                str = ['function varargout = ', functionName, '(varargin)', sprintf('\n'), ...
                    strGetFunctionMockery, sprintf('\n'), ...
                    'fcnMock = mockery.getFuncionMockByName(''', functionName, ''');', sprintf('\n'), ...
                    'varargout = fcnMock.call(varargin);', sprintf('\n'), ...
                    ['setappdata(0, ''', FunctionMockery.APPDATA_NAME, '_do_notclear''', ', 1);'], sprintf('\n'), ...
                    'end', sprintf('\n')];
                
                fid = fopen(mockFile, 'w+');
                fprintf(fid, '%s', str);
                fclose(fid);
                
                while ~exist(mockFile, 'file')
                    disp('paused')
                    pause(0.1);
                end
            end
            
            fcnMock = obj.getFuncionMockByName(functionName);
            
            if isempty(fcnMock)
                fcnMock = FunctionMock(functionName, fcnMockDir);
                obj.FunctionMocks{end+1} = fcnMock;
                MockLab.FunctionMockery.setAppDataInstance(obj.FunctionMocks);
            end
        end
        
    end
    
end


