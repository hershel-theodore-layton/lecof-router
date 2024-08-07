/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class LiteralFilterTest extends HackTest {
  use Assertions;

  public function test_forwards_when_literal_is_same()[defaults]: void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\literal('hello', Lecof\done($expected)),
      static::request('/hello'),
      $expected,
    );
  }

  public function test_bails_when_literal_is_different()[defaults]: void {
    $expected = static::rand();
    static::assertBails(
      Lecof\literal('hi', Lecof\done($expected)),
      static::request('/hello'),
    );
  }

  public function test_rejects_requests_when_you_specify_a_leading_slash(
  )[defaults]: void {
    $expected = static::rand();
    static::assertBails(
      Lecof\literal('/hello', Lecof\done($expected)),
      // DON'T SAY / ^^^^^^
      static::request('/hello'),
    );
  }
}
