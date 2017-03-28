classdef ArgumentMatchersTest < matlab.unittest.TestCase
    %FUNCTIONMOCKERY_TEST Summary of this class goes here
    %   Detailed explanation goes here

    methods(Test)
   
        function test_AnyArgs(self)
            errMessageMatch = 'AnyArgs matcher is not matching!';
            errMessageRemaining = 'AnyArgs matcher should collect all the args!';
            
            % 
            matcher = MockLab.ArgumentMatchers.anyArgs();
            
            % Empty arg list
            result = matcher.match({});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % Single argument
            result = matcher.match({'arg1'});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            result = matcher.match({1});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            result = matcher.match({struct()});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
             % More arguments
            result = matcher.match({'arg1', 'arg2'});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            result = matcher.match({1, 2, 'arg3'});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            result = matcher.match({struct(), 'a'});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
        end
        
        function test_AnyCell(self)
            errMessageMatch = 'AnyCell match result is wrong!';
            errMessageRemaining = 'AnyCell remaining args is wrong!';
            
            %
            matcher = MockLab.ArgumentMatchers.anyCell();
            
            % Empty arg list
            result = matcher.match({});
            assert(~result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % Single argument
            result = matcher.match({{}});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            result = matcher.match({{'a'}});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            result = matcher.match({{1}});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % More arguments
            result = matcher.match({'arg1', 'arg2'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(), {'arg1', 'arg2'}), errMessageRemaining);
            
            result = matcher.match({1, 2, 'arg3'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{1, 2, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({{'a', 'b'}, 'a', 1});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{'a', 1}), errMessageRemaining);
            
        end
        
        function test_AnyFloat(self)
            errMessageMatch = 'AnyFloat match result is wrong!';
            errMessageRemaining = 'AnyFloat remaining args is wrong!';
            
            %
            matcher = MockLab.ArgumentMatchers.anyFloat();
            
            % Empty arg list
            result = matcher.match({});
            assert(~result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % Single argument
            result = matcher.match({3});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            result = matcher.match({{'a'}});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{{'a'}}), errMessageRemaining);
            
             result = matcher.match({3.4});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
             result = matcher.match({int8(2)});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(), {int8(2)}), errMessageRemaining);

            % More arguments
            result = matcher.match({'arg1', 'arg2'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(), {'arg1', 'arg2'}), errMessageRemaining);
            
            result = matcher.match({1, 2, 'arg3'});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{2, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({12.3E4, 12.3E4, 'arg3'});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{12.3E4, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({struct(), 'a', 1});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{struct(), 'a', 1}), errMessageRemaining);
            
        end
        
        
        function test_AnyInteger(self)
            errMessageMatch = 'AnyInteger match result is wrong!';
            errMessageRemaining = 'AnyInteger remaining args is wrong!';
            
            %
            matcher = MockLab.ArgumentMatchers.anyInteger();
            
            % Empty arg list
            result = matcher.match({});
            assert(~result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % Single argument
            result = matcher.match({3});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{3}), errMessageRemaining);
            
            result = matcher.match({{'a'}});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{{'a'}}), errMessageRemaining);
            
            result = matcher.match({3.4});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{3.4}), errMessageRemaining);
            
            result = matcher.match({int16(20)});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            result = matcher.match({int32(11)});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            result = matcher.match({int64(555)});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % More arguments
            result = matcher.match({'arg1', 'arg2'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(), {'arg1', 'arg2'}), errMessageRemaining);
            
            result = matcher.match({1, 2, 'arg3'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{1, 2, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({12.3E4, 3, 'arg3'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{12.3E4, 3, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({int8(2), int16(1), 1});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{int16(1), 1}), errMessageRemaining);
            
        end
        
        function test_AnyLogical(self)
            errMessageMatch = 'AnyLogical match result is wrong!';
            errMessageRemaining = 'AnyLogical remaining args is wrong!';
            
            %
            matcher = MockLab.ArgumentMatchers.anyLogical();
            
            % Empty arg list
            result = matcher.match({});
            assert(~result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % Single argument
            result = matcher.match({3});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{3}), errMessageRemaining);
            
            result = matcher.match({{'a'}});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{{'a'}}), errMessageRemaining);
            
            result = matcher.match({3.4});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{3.4}), errMessageRemaining);
            
            result = matcher.match({true, false});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{false}), errMessageRemaining);
            
            result = matcher.match({false, true});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{true}), errMessageRemaining);
            
           
            
            % More arguments
            result = matcher.match({'arg1', 'arg2'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(), {'arg1', 'arg2'}), errMessageRemaining);
            
            result = matcher.match({1, 2, 'arg3'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{1, 2, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({12.3E4, 3, 'arg3'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{12.3E4, 3, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({true, 'a', 1});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{'a', 1}), errMessageRemaining);
            
        end
        
        function test_AnyMatrix(self)
            errMessageMatch = 'AnyMatrix match result is wrong!';
            errMessageRemaining = 'AnyMatrix remaining args is wrong!';
            
            %
            matcher = MockLab.ArgumentMatchers.anyMatrix();
            
            % Empty arg list
            result = matcher.match({});
            assert(~result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % Single argument
            result = matcher.match({3});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{3}), errMessageRemaining);
            
            result = matcher.match({{'a'}});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{{'a'}}), errMessageRemaining);
            
            result = matcher.match({3.4});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{3.4}), errMessageRemaining);
            
            result = matcher.match({[1 2 3], [2 3 4]});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[2 3 4]}), errMessageRemaining);
            
            result = matcher.match({[], [2 3 4]});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[2 3 4]}), errMessageRemaining);
            
           
            
            % More arguments
            result = matcher.match({'arg1', 'arg2'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(), {'arg1', 'arg2'}), errMessageRemaining);
            
            result = matcher.match({1, 2, 'arg3'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{1, 2, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({12.3E4, 3, 'arg3'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{12.3E4, 3, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({[1,2,3], 'a', 1});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{'a', 1}), errMessageRemaining);
            
        end
        
        
        
        
    end
    
end

