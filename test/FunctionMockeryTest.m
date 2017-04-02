classdef FunctionMockeryTest < matlab.unittest.TestCase
    % Tests Mocklab.FunctionMockery.
    
    properties
        TestDataPath;
    end
    
    methods(TestMethodSetup)
        function setup(self)
            self.TestDataPath = fullfile(fileparts(mfilename('fullpath')), 'testdata');
            addpath(self.TestDataPath);
        end
    end
    
    methods(TestMethodTeardown)
        function teardown(self)
            rmpath(self.TestDataPath);
        end
    end
    
    
    methods(Test)
        
        function test_FunctionMockeryCreation(self)
            % Factory can be retrieved
            fm = MockLab.FunctionMockery.getInstance();
            assert(isa(fm, 'MockLab.FunctionMockery'), 'FunctionMockery cannot be created');
        end
        
        function test_FunctionMockCreation(self)
            fcnName = 'mockedFcn';
            fm = MockLab.FunctionMockery.getInstance();
            
            % The function should be not on the path
            assert(numel(strfind(which(fcnName), fm.ROOT_DIR_NAME)) == 0, 'mockedFcn already exist in the directory');
            
            % FunctionMock is created => It should be visible
            fm.when('mockedFcn').thenReturn('mocked');
            assert(numel(strfind(which(fcnName), fm.ROOT_DIR_NAME)) == 1, 'mockedFcn was not added to the path');
            
            % Deleting the factory => FunctionMock should be removed
            rootDir = fm.ROOT_DIR_NAME;
            delete(fm);
            assert(numel(strfind(which(fcnName), rootDir)) == 0, 'FunctionMockery was not cleaned-up correctly');
        end
        
        
    end
    
end

