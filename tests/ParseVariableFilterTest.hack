/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function parse_variable_filter_test(TestChain\Chain $chain)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    ->test('test_forwards_when_the_parser_can_parse', ()[defaults] ==> {
      $expected = $assert->rand();
      $assert->assertReturns(
        Lecof\parse_variable(
          new AnythingGoesParser('var'),
          Lecof\done($expected),
        ),
        $assert->request('/anything'),
        $expected,
      );
    })
    ->test('test_bails_when_the_parser_can_not_parse', () ==> {
      $assert->assertBails(
        Lecof\parse_variable(new FailingParser(), Lecof\done(42)),
        $assert->request('/fails'),
      );
    })
    ->test('test_variables_are_parsed', () ==> {
      $assert->assertHasVariables(
        Lecof\parse_variable(new StringReverseParser('var'), Lecof\done(42)),
        $assert->request('/esrever'),
        dict['var' => 'reverse'],
      );
    })
    ->test('test_variables_from_a_nested_filter_are_retained', () ==> {
      $assert->assertHasVariables(
        Lecof\parse_variable(
          new StringReverseParser('outer'),
          Lecof\parse_variable(
            new StringReverseParser('inner'),
            Lecof\done(42),
          ),
        ),
        $assert->request('/retuo/54321'),
        dict['outer' => 'outer', 'inner' => '12345'],
      );
    });
}
