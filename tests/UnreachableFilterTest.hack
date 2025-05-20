/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function unreachable_filter_test(TestChain\Chain $chain)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    ->test('test_throws_an_invariant_exception_with_custom_message', () ==> {
      $assert->assertThrowsExactType<InvariantException>(
        Lecof\unreachable('%s should not %s', 'This', 'happen'),
        $assert->request(),
        'This should not happen',
      );
    });
}
