classdef InvocationTest < matlab.unittest.TestCase
    % Tests MockLab.Invocation.Invocation.
    
    methods(Test)
        
        function test_matchArgumentMatchers(self)
            
            dateTime = now();
            invocation = MockLab.Invocation.Invocation('testMethod', {'a', 1}, dateTime);
            argMatcherList = MockLab.Matchers.ArgumentMatcherList('a', 1);
            
            matches = invocation.matchArgumentMatchers('testMethod', argMatcherList);
            assert(matches, 'Invocation does not match');
            assert(~invocation.isVerified(), 'Invocation is verified!');
            
            matches = invocation.matchArgumentMatchers('testMethod2', argMatcherList);
            assert(~matches, 'Invocation does match');
            assert(~invocation.isVerified(), 'Invocation is verified!');
            
            argMatcherList = MockLab.Matchers.ArgumentMatcherList('b', 1);
            matches = invocation.matchArgumentMatchers('testMethod', argMatcherList);
            assert(~matches, 'Invocation does match');
            assert(~invocation.isVerified(), 'Invocation is verified!');
            
        end
        
        function test_verifyArgumentMatchers(self)
            
            dateTime = now();
            invocation = MockLab.Invocation.Invocation('testMethod', {'a', 1}, dateTime);
            argMatcherList = MockLab.Matchers.ArgumentMatcherList('b', 1);
            
            matches = invocation.verifyArgumentMatchers('testMethod2', argMatcherList);
            assert(~matches, 'Invocation does match');
            assert(~invocation.isVerified(), 'Invocation is verified!');
            
            
            matches = invocation.verifyArgumentMatchers('testMethod', argMatcherList);
            assert(~matches, 'Invocation does match');
            assert(~invocation.isVerified(), 'Invocation is verified!');
            
            argMatcherList = MockLab.Matchers.ArgumentMatcherList('a', 1);
            matches = invocation.verifyArgumentMatchers('testMethod', argMatcherList);
            assert(matches, 'Invocation does not match');
            assert(invocation.isVerified(), 'Invocation is not verified!');
        end
    end
    
end

