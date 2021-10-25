/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class LiteralFilterTest extends HackTest {
  use Assertions;

  public function test_forwards_when_literal_is_same(): void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\literal('hello', Lecof\done($expected)),
      static::request('/hello'),
      $expected,
    );
  }

  public function test_bails_when_literal_is_different(): void {
    $expected = static::rand();
    static::assertBails(
      Lecof\literal('hi', Lecof\done($expected)),
      static::request('/hello'),
    );
  }

  public function test_rejects_requests_when_you_specify_a_leading_slash(
  ): void {
    $expected = static::rand();
    static::assertBails(
      Lecof\literal('/hello', Lecof\done($expected)),
      // DON'T SAY / ^^^^^^
      static::request('/hello'),
    );
  }

  public function test_does_increment_index(): void {
    list($memory, $filter) = static::mem(Lecof\done(42));
    static::assertIncrementsIndex(
      Lecof\literal('hello', $filter),
      static::request('/hello'),
      $memory,
    );
  }
}
