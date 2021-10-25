/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class NullFilterTest extends HackTest {
  use Assertions;

  public function test_always_bails(): void {
    static::assertBails(Lecof\null(), static::request());
  }
}
