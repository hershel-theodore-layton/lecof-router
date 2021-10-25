/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class LazyFilterTest extends HackTest {
  use Assertions;

  public function test_returns_from_the_unwrapped_next_filter(): void {
    $expect = static::rand();
    static::assertReturns(
      Lecof\lazy(() ==> Lecof\done($expect)),
      static::request(),
      $expect,
    );
  }

  public function test_does_not_invoke_function_greedily(): void {
    Lecof\lazy(() ==> {
      invariant_violation('I am not invoked if not needed');
    });
  }
}
