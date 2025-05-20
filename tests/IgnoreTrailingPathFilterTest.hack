/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function ignore_trailing_path_filter_test(
  TestChain\Chain $chain,
)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    ->test('test_returns_from_next', ()[defaults] ==> {
      $expect = $assert->rand();
      $assert->assertReturns(
        Lecof\ignore_trailing_path(Lecof\done($expect)),
        $assert->request(),
        $expect,
      );
    })
    ->test('test_forwards_index_to_end_of_path', ()[defaults] ==> {
      $expect = $assert->rand();
      $assert->assertReturns(
        Lecof\ignore_trailing_path(Lecof\done($expect)),
        $assert->request('/a/b/c/d/e/f/g/h'),
        $expect,
      );
    });
}
