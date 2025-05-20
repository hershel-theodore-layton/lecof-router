/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};
use function HTL\Expect\expect;

<<TestChain\Discover>>
function merged_filter_test(TestChain\Chain $chain)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    /**
     * THIS IS AN IMPLEMENTATION DETAIL!
     * THIS TEST ONLY EXISTS TO REMIND EVERYONE THAT IT IS.
     * IF YOUR CODE BREAKS IF MERGE RETURNS A WRAPPED FILTER
     * WHEN ONE ARGUMENT IS SUPPLIED, YOUR CODE IS BROKEN!
     */
    ->test(
      'test_merge_returns_the_first_if_no_second_argument_is_given',
      () ==> {
        $inner = Lecof\done(42);
        // IMPLEMENTATION DETAIL!!!
        expect(Lecof\merge($inner))->toEqual($inner);
      },
    )
    ->test('test_merge_returns_the_first_successful_match', ()[defaults] ==> {
      $expected = $assert->rand();
      $assert->assertReturns(
        Lecof\merge(Lecof\done($expected), Lecof\null()),
        $assert->request(),
        $expected,
      );
    })
    ->test('test_merge_bails_if_no_children_match', () ==> {
      $assert->assertBails(
        Lecof\merge(Lecof\null(), Lecof\null()),
        $assert->request(),
      );
    })
    ->test(
      'test_merge_returns_the_first_successful_match_and_ignores_further_filters',
      ()[defaults] ==> {
        $expected = $assert->rand();
        $assert->assertReturns(
          Lecof\merge(
            Lecof\null(),
            Lecof\null(),
            Lecof\done($expected),
            Lecof\done('Must Lecof\done($expected)'),
          ),
          $assert->request(),
          $expected,
        );
      },
    )
    ->test(
      'test_merge_short_circuits_when_one_match_is_found',
      ()[defaults] ==> {
        $expected = $assert->rand();
        $assert->assertReturns(
          Lecof\merge(
            Lecof\null(),
            Lecof\null(),
            Lecof\done($expected),
            Lecof\unreachable('Must Lecof\done($expected)'),
          ),
          $assert->request(),
          $expected,
        );
      },
    );
}
