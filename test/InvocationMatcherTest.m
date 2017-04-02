classdef InvocationMatcherTest < matlab.unittest.TestCase
    % Tests MockLab.Invocation.InvocationMatcher and InvocationMatch.
    
    methods(Test)
        
        function test_match(self)
            
            %%
            subStr = substruct('.', 'functioname', '()', {});
            invMatch = MockLab.Invocation.InvocationMatcher.match(subStr);
            
            assert(isempty(invMatch.getRemainingInvocation()), 'Remaining invocation is not empty');
            inv = invMatch.getInvocation();
            assert(~isempty(inv), 'Invocation is empty');
            assert(isempty(inv.getArgumentList()), 'Invocation argument list is not empty');
            assert(isequal(inv.getMethodName(), 'functioname'), 'Invocation name mismatch');
            
            %%
            subStr = substruct('.', 'functioname', '()', {'a', 'b', 1});
            invMatch = MockLab.Invocation.InvocationMatcher.match(subStr);
            
            assert(isempty(invMatch.getRemainingInvocation()), 'Remaining invocation is not empty');
            inv = invMatch.getInvocation();
            assert(~isempty(inv), 'Invocation is empty');
            assert(isequal(inv.getArgumentList(), {'a', 'b', 1}), 'Invocation argument list mistmatch');
            assert(isequal(inv.getMethodName(), 'functioname'), 'Invocation name mismatch');
            
            %%
            subStr = substruct('.', 'functioname', '()', {'a', 'b', 1}, '.', 'functioname2', '()', {5, 6});
            invMatch = MockLab.Invocation.InvocationMatcher.match(subStr);
            
            
            inv = invMatch.getInvocation();
            assert(~isempty(inv), 'Invocation is empty');
            assert(isequal(inv.getArgumentList(), {'a', 'b', 1}), 'Invocation argument list mistmatch');
            assert(isequal(inv.getMethodName(), 'functioname'), 'Invocation name mismatch');
            
            remInv = invMatch.getRemainingInvocation();
            assert(isequal(numel(remInv), 2), 'Remaining invocation length mismatch');
            assert(isequal(remInv(1).type, '.'), 'Remaining invocation mismatch');
            assert(isequal(remInv(1).subs, 'functioname2'), 'Remaining invocation mismatch');
            assert(isequal(remInv(2).type, '()'), 'Remaining invocation mismatch');
            assert(isequal(remInv(2).subs, {5, 6}), 'Remaining invocation mismatch');
            
            
        end
    end
    
end

