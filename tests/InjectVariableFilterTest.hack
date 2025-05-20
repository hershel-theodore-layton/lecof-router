/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function inject_variable_filter_test(
  TestChain\Chain $chain,
)[]: TestChain\Chain {
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
    });
}
