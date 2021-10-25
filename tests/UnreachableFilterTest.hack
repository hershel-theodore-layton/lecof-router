/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class UnreachableFilterTest extends HackTest {
  use Assertions;

  public function test_throws_an_invariant_exception_with_custom_message(
  ): void {
    static::assertThrowsExactType(
      Lecof\unreachable('%s should not %s', 'This', 'happen'),
      static::request(),
      InvariantException::class,
      'This should not happen',
    );
  }
}
