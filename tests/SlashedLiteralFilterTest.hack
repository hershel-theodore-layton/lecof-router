/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class SlashedLiteralFilterTest extends HackTest {
  use Assertions;

  public function test_forwards_when_literal_is_same(): void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\slashed_literal('hello', Lecof\done($expected)),
      static::request('/hello'),
      $expected,
    );
  }

  public function test_bails_when_literal_is_different(): void {
    $expected = static::rand();
    static::assertBails(
      Lecof\slashed_literal('hi', Lecof\done($expected)),
      static::request('/hello'),
    );
  }

  public function test_forwards_when_rest_matches(): void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\slashed_literal('very/many/parts', Lecof\done($expected)),
      static::request('/very/many/parts'),
      $expected,
    );
  }

  public function test_bails_when_one_part_of_rest_is_different(): void {
    $expected = static::rand();
    static::assertBails(
      Lecof\slashed_literal('very/many/parts', Lecof\done($expected)),
      static::request('/very/few/parts'),
    );
  }

  public function test_bails_on_a_partial_match(): void {
    $expected = static::rand();
    static::assertBails(
      Lecof\slashed_literal('very/many', Lecof\done($expected)),
      static::request('/very/many/parts'),
    );
  }

  public function test_does_increment_index(): void {
    $request = static::request('/very/many/parts');
    list($memory, $filter) = static::mem(Lecof\null());

    static::assertExhaustsPath(
      Lecof\slashed_literal('very/many/parts', $filter),
      $request,
      $memory,
    );
  }
}
