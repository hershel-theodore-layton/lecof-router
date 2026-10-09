/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HH;
use namespace HTL\TestChain;
use function HTL\Expect\{expect, expect_invoked};

<<TestChain\Discover>>
function request_info_test(TestChain\Chain $chain)[]: TestChain\Chain {
  return $chain->group(__FUNCTION__)
    ->test('absent_optional_extension_returns_null', () ==> {
      expect((new RequestInfo('/'))->getByType<string>())->toBeNull();
    })
    ->test('absent_required_extension_throws', () ==> {
      expect_invoked(() ==> (new RequestInfo('/'))->getByTypex<string>())
        ->toHaveThrown<HH\InvariantException>('No extensions available');
    });
}
