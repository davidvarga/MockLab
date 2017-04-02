classdef ArgumentMatcherListTest < matlab.unittest.TestCase
    % Tests MockLab.Matchers.ArgumentMatcherList.
    
    methods(Test)
        
        function test_Constructor_NoArg(self)
            argMatcherList = MockLab.Matchers.ArgumentMatcherList();
            assert(isempty(argMatcherList.getArgumentMatchers()), 'Argument matcher list is not empty');
        end
        
        function test_Constructor_OneArg(self)
            argMatcherList = MockLab.Matchers.ArgumentMatcherList('a');
            argMatchers = argMatcherList.getArgumentMatchers();
            assert(isequal(numel(argMatchers), 1), 'Argument matcher list is not 1 long');
            assert(isa(argMatchers{1}, 'MockLab.Matchers.ArgEqual'), 'ArgumentMatcher type mismatch');
            assert(isequal(argMatchers{1}.getArgumentValue(), 'a'), 'ArgumentMatcher value mismatch');
            
            matcher = MockLab.ArgumentMatchers.anyCell();
            argMatcherList = MockLab.Matchers.ArgumentMatcherList(matcher);
            argMatchers = argMatcherList.getArgumentMatchers();
            assert(isequal(numel(argMatchers), 1), 'Argument matcher list is not 1 long');
            assert(isequal(argMatchers{1}, matcher), 'ArgumentMatcher type mismatch');
        end
        
        function test_Constructor_MoreArg(self)
            matcher = MockLab.ArgumentMatchers.anyNumber();
            argMatcherList = MockLab.Matchers.ArgumentMatcherList(matcher, 2);
            argMatchers = argMatcherList.getArgumentMatchers();
            assert(isequal(numel(argMatchers), 2), 'Argument matcher list is not 2 long');
            assert(isequal(argMatchers{1}, matcher), 'ArgumentMatcher type mismatch');
            assert(isa(argMatchers{2}, 'MockLab.Matchers.ArgEqual'), 'ArgumentMatcher type mismatch');
            assert(isequal(argMatchers{2}.getArgumentValue(), 2), 'ArgumentMatcher value mismatch');
            
            matcher = MockLab.ArgumentMatchers.anyScalar();
            matcher2 = MockLab.ArgumentMatchers.anyString();
            argMatcherList = MockLab.Matchers.ArgumentMatcherList({1, 2, 3}, matcher, matcher2);
            argMatchers = argMatcherList.getArgumentMatchers();
            assert(isequal(numel(argMatchers), 3), 'Argument matcher list is not 3 long');
            
            assert(isa(argMatchers{1}, 'MockLab.Matchers.ArgEqual'), 'ArgumentMatcher type mismatch');
            assert(isequal(argMatchers{1}.getArgumentValue(), {1, 2, 3}), 'ArgumentMatcher value mismatch');
            
            assert(isequal(argMatchers{2}, matcher), 'ArgumentMatcher type mismatch');
            assert(isequal(argMatchers{3}, matcher2), 'ArgumentMatcher type mismatch');
        end
    end
    
end

