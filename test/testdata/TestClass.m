classdef TestClass < handle
    %TESTCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1;
        Property2;
    end
    
    methods
        function retArg = returnThree(obj)
           retArg = 3; 
        end
        
        function retArg = addition(obj, arg1, arg2)
           retArg = arg1 + arg2; 
        end
        
    end
    
end

