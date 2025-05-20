/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function lazy_filter_test(TestChain\Chain $chain)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    ->test('test_returns_from_the_unwrapped_next_filter', ()[defaults] ==> {
      $expect = $assert->rand();
      $assert->assertReturns(
        Lecof\lazy(()[] ==> Lecof\done($expect)),
        $assert->request(),
        $expect,
      );
    })
    ->test('test_does_not_invoke_function_greedily', () ==> {
      Lecof\lazy(()[] ==> {
        invariant_violation('I am not invoked if not needed');
      });
    });
}
