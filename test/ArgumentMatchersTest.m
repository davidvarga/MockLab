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
            
            
            % More arguments
            
            result = matcher.match({true, false});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{false}), errMessageRemaining);
            
            result = matcher.match({false, true});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{true}), errMessageRemaining);
            
            
            
            
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
        
        %         function test_AnyMatrix(self)
        %             errMessageMatch = 'AnyMatrix match result is wrong!';
        %             errMessageRemaining = 'AnyMatrix remaining args is wrong!';
        %
        %             %
        %             matcher = MockLab.ArgumentMatchers.anyMatrix();
        %
        %             % Empty arg list
        %             result = matcher.match({});
        %             assert(~result.isMatched(), errMessageMatch);
        %             assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
        %
        %             % Single argument
        %             result = matcher.match({3});
        %             assert(result.isMatched(), errMessageMatch);
        %            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
        %
        % %             result = matcher.match({{'a'}});
        % %             assert(~result.isMatched(), errMessageMatch);
        % %             assert(isequal(result.getUnmatchedArguments(),{{'a'}}), errMessageRemaining);
        %
        %             result = matcher.match({3.4});
        %             assert(result.isMatched(), errMessageMatch);
        %             assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
        %
        %             result = matcher.match({[1 2 3], [2 3 4]});
        %             assert(result.isMatched(), errMessageMatch);
        %             assert(isequal(result.getUnmatchedArguments(),{[2 3 4]}), errMessageRemaining);
        %
        %             result = matcher.match({[], [2 3 4]});
        %             assert(result.isMatched(), errMessageMatch);
        %             assert(isequal(result.getUnmatchedArguments(),{[2 3 4]}), errMessageRemaining);
        %
        %
        %
        %             % More arguments
        %             result = matcher.match({'arg1', 'arg2'});
        %             assert(~result.isMatched(), errMessageMatch);
        %             assert(isequal(result.getUnmatchedArguments(), {'arg1', 'arg2'}), errMessageRemaining);
        %
        %             result = matcher.match({1, 2, 'arg3'});
        %             assert(result.isMatched(), errMessageMatch);
        %             assert(isequal(result.getUnmatchedArguments(),{2, 'arg3'}), errMessageRemaining);
        %
        %             result = matcher.match({12.3E4, 3, 'arg3'});
        %             assert(result.isMatched(), errMessageMatch);
        %             assert(isequal(result.getUnmatchedArguments(),{3, 'arg3'}), errMessageRemaining);
        %
        %             result = matcher.match({[1,2,3], 'a', 1});
        %             assert(result.isMatched(), errMessageMatch);
        %             assert(isequal(result.getUnmatchedArguments(),{'a', 1}), errMessageRemaining);
        %
        %         end
        
        function test_AnyNumber(self)
            errMessageMatch = 'AnyNumber match result is wrong!';
            errMessageRemaining = 'AnyNumber remaining args is wrong!';
            
            %
            matcher = MockLab.ArgumentMatchers.anyNumber();
            
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
            
            
            % More arguments
            
            result = matcher.match({[1 2 3], [2 3 4]});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[2 3 4]}), errMessageRemaining);
            
            result = matcher.match({[], [2 3 4]});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[2 3 4]}), errMessageRemaining);
            
            
            
            
            result = matcher.match({'arg1', 'arg2'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(), {'arg1', 'arg2'}), errMessageRemaining);
            
            result = matcher.match({1, 2, 'arg3'});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{2, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({12.3E4, 3, 'arg3'});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{ 3, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({[1,2,3], 'a', 1});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{'a', 1}), errMessageRemaining);
            
        end
        
        function test_AnyScalar(self)
            errMessageMatch = 'AnyScalar match result is wrong!';
            errMessageRemaining = 'AnyScalar remaining args is wrong!';
            
            %
            matcher = MockLab.ArgumentMatchers.anyScalar();
            
            % Empty arg list
            result = matcher.match({});
            assert(~result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % Single argument
            result = matcher.match({3});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            
            result = matcher.match({{'a'}});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            result = matcher.match({3.4});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            
            % More arguments
            
            result = matcher.match({[1 2 3], [2 3 4]});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[1 2 3],[2 3 4]}), errMessageRemaining);
            
            result = matcher.match({[], [2 3 4]});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[], [2 3 4]}), errMessageRemaining);
            
            
            
            result = matcher.match({'arg1', 'arg2'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(), {'arg1', 'arg2'}), errMessageRemaining);
            
            result = matcher.match({1, 2, 'arg3'});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{2, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({12.3E4, 3, 'arg3'});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{ 3, 'arg3'}), errMessageRemaining);
            
            result = matcher.match({[1,2,3], 'a', 1});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[1,2,3], 'a', 1}), errMessageRemaining);
            
        end
        
        function test_AnyString(self)
            errMessageMatch = 'AnyString match result is wrong!';
            errMessageRemaining = 'AnyString remaining args is wrong!';
            
            %
            matcher = MockLab.ArgumentMatchers.anyString();
            
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
            
            result = matcher.match({'aaa'});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            
            % More arguments
            
            result = matcher.match({[1 2 3], [2 3 4]});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[1 2 3],[2 3 4]}), errMessageRemaining);
            
            result = matcher.match({[], [2 3 4]});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[], [2 3 4]}), errMessageRemaining);
            
            
            
            result = matcher.match({'arg1', 'arg2'});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(), {'arg2'}), errMessageRemaining);
            
            result = matcher.match({1, 2, 'arg3'});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{1, 2, 'arg3'}), errMessageRemaining);
            
            
        end
        
        function test_AnyStruct(self)
            errMessageMatch = 'AnyStruct match result is wrong!';
            errMessageRemaining = 'AnyStruct remaining args is wrong!';
            
            %
            matcher = MockLab.ArgumentMatchers.anyStruct();
            
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
            
            result = matcher.match({struct()});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            
            % More arguments
            
            result = matcher.match({[1 2 3], [2 3 4]});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[1 2 3],[2 3 4]}), errMessageRemaining);
            
            result = matcher.match({[], [2 3 4]});
            assert(~result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[], [2 3 4]}), errMessageRemaining);
            
            
            
            result = matcher.match({struct(), 'arg2'});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(), {'arg2'}), errMessageRemaining);
            
        end
        
        function test_ArgEqual(self)
            errMessageMatch = 'ArgEqual match result is wrong!';
            errMessageRemaining = 'ArgEqual remaining args is wrong!';
            
            %
            
            
            % Empty arg list
            matcher = MockLab.ArgumentMatchers.argEqual({});
            result = matcher.match({});
            assert(~result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % Single argument
            matcher = MockLab.ArgumentMatchers.argEqual(3);
            result = matcher.match({3});
            result2 = matcher.match({5});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            assert(~result2.isMatched(), errMessageMatch);
            assert(isequal(result2.getUnmatchedArguments(),{5}), errMessageRemaining);
            
            matcher = MockLab.ArgumentMatchers.argEqual('a');
            result = matcher.match({'a'});
            result2 = matcher.match({'b'});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            assert(~result2.isMatched(), errMessageMatch);
            assert(isequal(result2.getUnmatchedArguments(),{'b'}), errMessageRemaining);
            
            matcher = MockLab.ArgumentMatchers.argEqual(3.4);
            result = matcher.match({3.4});
            result2 = matcher.match({3.41});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            assert(~result2.isMatched(), errMessageMatch);
            assert(isequal(result2.getUnmatchedArguments(),{3.41}), errMessageRemaining);
            
            struc = struct();
            struc.a = 'a';
            matcher = MockLab.ArgumentMatchers.argEqual(struc);
            result = matcher.match({struc});
            s = struct();
            s.a = 'b';
            result2 = matcher.match({s});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            assert(~result2.isMatched(), errMessageMatch);
            assert(isequal(result2.getUnmatchedArguments(),{s}), errMessageRemaining);
            
            
            % More arguments
            matcher = MockLab.ArgumentMatchers.argEqual([1 2 3]);
            result = matcher.match({[1 2 3], [2 3 4]});
            result2 = matcher.match({[2 3 4], [2 3 4]});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[2 3 4]}), errMessageRemaining);
            assert(~result2.isMatched(), errMessageMatch);
            assert(isequal(result2.getUnmatchedArguments(),{[2 3 4], [2 3 4]}), errMessageRemaining);
            
             matcher = MockLab.ArgumentMatchers.argEqual([]);
            result = matcher.match({[], [2 3 4]});
            result2 = matcher.match({1, [2 3 4]});
            assert(result.isMatched(), errMessageMatch);
            assert(isequal(result.getUnmatchedArguments(),{[2 3 4]}), errMessageRemaining);
            assert(~result2.isMatched(), errMessageMatch);
            assert(isequal(result2.getUnmatchedArguments(),{1, [2 3 4]}), errMessageRemaining);
        end
        
        function test_Any(self)
            errMessageMatch = 'Any match result is wrong!';
            errMessageRemaining = 'Any remaining args is wrong!';
            
            %
            
            
            % Empty arg list
            matcher = MockLab.ArgumentMatchers.any();
            result = matcher.match({});
            assert(~result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            matcher = MockLab.ArgumentMatchers.any('double');
            result = matcher.match({});
            assert(~result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            
            % Single argument
            matcher = MockLab.ArgumentMatchers.any();
            result = matcher.match({'a'});
            result2 = matcher.match({{}});
            result3 = matcher.match({1});
            result4 = matcher.match({struct()});
            result5 = matcher.match({[1, 2, 3]});
            
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            assert(result2.isMatched(), errMessageMatch);
            assert(isempty(result2.getUnmatchedArguments()), errMessageRemaining);
            assert(result3.isMatched(), errMessageMatch);
            assert(isempty(result3.getUnmatchedArguments()), errMessageRemaining);
            assert(result4.isMatched(), errMessageMatch);
            assert(isempty(result4.getUnmatchedArguments()), errMessageRemaining);
            assert(result5.isMatched(), errMessageMatch);
            assert(isempty(result5.getUnmatchedArguments()), errMessageRemaining);
            
            matcher = MockLab.ArgumentMatchers.any('double');
            result = matcher.match({1});
            result2 = matcher.match({'a'});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            assert(~result2.isMatched(), errMessageMatch);
            assert(isequal(result2.getUnmatchedArguments(),{'a'}), errMessageRemaining);
            
            matcher = MockLab.ArgumentMatchers.any('TestClass');
            result = matcher.match({TestClass()});
            result2 = matcher.match({1});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            assert(~result2.isMatched(), errMessageMatch);
            assert(isequal(result2.getUnmatchedArguments(),{1}), errMessageRemaining);
            
            matcher = MockLab.ArgumentMatchers.any('cell');
            result = matcher.match({{1,2,3}});
            tc = TestClass();
            result2 = matcher.match({tc});
            assert(result.isMatched(), errMessageMatch);
            assert(isempty(result.getUnmatchedArguments()), errMessageRemaining);
            assert(~result2.isMatched(), errMessageMatch);
            assert(isequal(result2.getUnmatchedArguments(),{tc}), errMessageRemaining);
           
            % More arguments
%             matcher = MockLab.ArgumentMatchers.argEqual([1 2 3]);
%             result = matcher.match({[1 2 3], [2 3 4]});
%             result2 = matcher.match({[2 3 4], [2 3 4]});
%             assert(result.isMatched(), errMessageMatch);
%             assert(isequal(result.getUnmatchedArguments(),{[2 3 4]}), errMessageRemaining);
%             assert(~result2.isMatched(), errMessageMatch);
%             assert(isequal(result2.getUnmatchedArguments(),{[2 3 4], [2 3 4]}), errMessageRemaining);
%             
%              matcher = MockLab.ArgumentMatchers.argEqual([]);
%             result = matcher.match({[], [2 3 4]});
%             result2 = matcher.match({1, [2 3 4]});
%             assert(result.isMatched(), errMessageMatch);
%             assert(isequal(result.getUnmatchedArguments(),{[2 3 4]}), errMessageRemaining);
%             assert(~result2.isMatched(), errMessageMatch);
%             assert(isequal(result2.getUnmatchedArguments(),{1, [2 3 4]}), errMessageRemaining);
        end
        
        
        
        
    end
    
end

