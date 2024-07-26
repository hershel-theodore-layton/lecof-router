/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class IgnoreTrailingPathFilterTest extends HackTest {
  use Assertions;

  public function test_returns_from_next()[defaults]: void {
    $expect = static::rand();
    static::assertReturns(
      Lecof\ignore_trailing_path(Lecof\done($expect)),
      static::request(),
      $expect,
    );
  }

  public function test_forwards_index_to_end_of_path()[defaults]: void {
    $expect = static::rand();
    static::assertReturns(
      Lecof\ignore_trailing_path(Lecof\done($expect)),
      static::request('/a/b/c/d/e/f/g/h'),
      $expect,
    );
  }
}
