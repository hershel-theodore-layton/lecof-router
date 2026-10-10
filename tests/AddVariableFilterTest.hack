/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function add_variable_filter_test(TestChain\Chain $chain)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    ->test('test_returns_the_value_of_the_inner_filter', ()[defaults] ==> {
      $expected = $assert->rand();
      $assert->assertReturns(
        Lecof\inject_variable(
          new VariableHolder('var', 'hi', 'hello'),
          Lecof\done($expected),
        ),
        $assert->request('/anything'),
        $expected,
      );
    })
    ->test('test_bails_if_inner_bails', () ==> {
      $assert->assertBails(
        Lecof\inject_variable(
          new VariableHolder('var', 'meh', '_'),
          Lecof\null(),
        ),
        $assert->request('/hello'),
      );
    })
    ->test('test_bails_when_the_parser_can_not_parse', () ==> {
      $assert->assertHasVariables(
        Lecof\inject_variable(
          new VariableHolder('var', 'hi', 'hello'),
          Lecof\done(42),
        ),
        $assert->request('/anything'),
        dict['var' => 'hello'],
      );
    })
    ->test('test_variables_from_a_nested_filter_are_retained', () ==> {
      $assert->assertHasVariables(
        Lecof\inject_variable(
          new VariableHolder('outer', 'letters', 'abc'),
          Lecof\inject_variable(
            new VariableHolder('inner', 'numbers', '123'),
            Lecof\done(42),
          ),
        ),
        $assert->request('/retuo/54321'),
        dict['outer' => 'abc', 'inner' => '123'],
      );
    })
    ->test('test_add_variable_preserves_the_path_segment', () ==> {
      $filter = Lecof\add_variable(
        new VariableHolder('var', 'hi', 'hello'),
        Lecof\literal('users', Lecof\done(42)),
      );
      $assert->assertReturns($filter, $assert->request('/users'), 42);
      $assert->assertHasVariables(
        $filter,
        $assert->request('/users'),
        dict['var' => 'hello'],
      );
      $assert->assertBails($filter, $assert->request('/skipped/users'));
    })
    ->test('test_add_variable_bails_if_inner_bails', () ==> {
      $assert->assertBails(
        Lecof\add_variable(
          new VariableHolder('var', 'hi', 'hello'),
          Lecof\null(),
        ),
        $assert->request(),
      );
    })
    ->test('test_nested_add_variable_preserves_variables_and_path', () ==> {
      $assert->assertHasVariables(
        Lecof\add_variable(
          new VariableHolder('outer', 'letters', 'abc'),
          Lecof\add_variable(
            new VariableHolder('inner', 'numbers', '123'),
            Lecof\done(42),
          ),
        ),
        $assert->request(),
        dict['outer' => 'abc', 'inner' => '123'],
      );
    })
    ->test('test_default_variable_does_not_swallow_a_parsed_segment', () ==> {
      $filter = Lecof\literal('api', Lecof\literal('users', Lecof\merge(
        Lecof\add_variable(
          new VariableHolder('page', '1', '1'),
          Lecof\done('default'),
        ),
        Lecof\parse_variable(
          new AnythingGoesParser('page'),
          Lecof\done('parsed'),
        ),
      )));
      $assert->assertReturns($filter, $assert->request('/api/users'), 'default');
      $assert->assertHasVariables(
        $filter,
        $assert->request('/api/users'),
        dict['page' => '1'],
      );
      $assert->assertReturns(
        $filter,
        $assert->request('/api/users/123'),
        'parsed',
      );
      $assert->assertHasVariables(
        $filter,
        $assert->request('/api/users/123'),
        dict['page' => '123'],
      );
      $assert->assertBails($filter, $assert->request('/api/users/123/extra'));
    })
    ->testWith2Params(
      'test_explicit_skip_matches_legacy_behavior',
      () ==> {
        $variable = new VariableHolder('var', 'hi', 'hello');
        return dict[
          'legacy inject_variable' => tuple(
            Lecof\inject_variable($variable, Lecof\literal('users', Lecof\done(42))),
            dict['var' => 'hello'],
          ),
          'explicit add_variable_skip_path_segment' => tuple(
            Lecof\add_variable_skip_path_segment($variable, Lecof\literal('users', Lecof\done(42))),
            dict['var' => 'hello'],
          ),
        ];
      },
      ($filter, $variables) ==> {
        $assert->assertBails($filter, $assert->request('/users'));
        $assert->assertReturns($filter, $assert->request('/skipped/users'), 42);
        $assert->assertHasVariables($filter, $assert->request('/skipped/users'), $variables);
      },
    );
}
