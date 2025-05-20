/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function null_filter_test(TestChain\Chain $chain)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    ->test('test_always_bails', () ==> {
      $assert->assertBails(Lecof\null(), $assert->request());
    });
}
