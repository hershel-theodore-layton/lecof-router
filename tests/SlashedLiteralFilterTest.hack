/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class SlashedLiteralFilterTest extends HackTest {
  use Assertions;

  public function test_forwards_when_literal_is_same()[defaults]: void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\slashed_literal('hello', Lecof\done($expected)),
      static::request('/hello'),
      $expected,
    );
  }

  public function test_bails_when_literal_is_different()[defaults]: void {
    $expected = static::rand();
    static::assertBails(
      Lecof\slashed_literal('hi', Lecof\done($expected)),
      static::request('/hello'),
    );
  }

  public function test_forwards_when_rest_matches()[defaults]: void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\slashed_literal('very/many/parts', Lecof\done($expected)),
      static::request('/very/many/parts'),
      $expected,
    );
  }

  public function test_bails_when_one_part_of_rest_is_different(
  )[defaults]: void {
    $expected = static::rand();
    static::assertBails(
      Lecof\slashed_literal('very/many/parts', Lecof\done($expected)),
      static::request('/very/few/parts'),
    );
  }

  public function test_bails_on_a_partial_match()[defaults]: void {
    $expected = static::rand();
    static::assertBails(
      Lecof\slashed_literal('very/many', Lecof\done($expected)),
      static::request('/very/many/parts'),
    );
  }
}
