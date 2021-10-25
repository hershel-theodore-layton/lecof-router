/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class DoneFilterTest extends HackTest {
  use Assertions;

  public function test_returns_what_it_has_been_given_if_path_has_been_exhausted(
  ): void {
    $expect = static::rand();
    static::assertReturns(Lecof\done($expect), static::request(), $expect);
  }

  public function test_returns_null_if_path_has_not_been_exhausted(): void {
    static::assertBails(Lecof\done(5), static::request('/hi'));
  }
}
