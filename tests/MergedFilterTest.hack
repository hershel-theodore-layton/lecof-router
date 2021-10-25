/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;

final class MergedFilterTest extends HackTest {
  use Assertions;

  /**
   * THIS IS AN IMPLEMENTATION DETAIL!
   * THIS TEST ONLY EXISTS TO REMIND EVERYONE THAT IT IS.
   * IF YOUR CODE BREAKS IF MERGE RETURNS A WRAPPED FILTER
   * WHEN ONE ARGUMENT IS SUPPLIED, YOUR CODE IS BROKEN!
   */
  public function test_merge_returns_the_first_if_no_second_argument_is_given(
  ): void {
    $inner = Lecof\done(42);
    // IMPLEMENTATION DETAIL!!!
    expect(Lecof\merge($inner))->toEqual($inner);
  }

  public function test_merge_returns_the_first_successful_match(): void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\merge(Lecof\done($expected), Lecof\null()),
      static::request(),
      $expected,
    );
  }

  public function test_merge_bails_if_no_children_match(): void {
    static::assertBails(
      Lecof\merge(Lecof\null(), Lecof\null()),
      static::request(),
    );
  }

  public function test_merge_returns_the_first_successful_match_and_ignores_further_filters(
  ): void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\merge(
        Lecof\null(),
        Lecof\null(),
        Lecof\done($expected),
        Lecof\done('Must Lecof\done($expected)'),
      ),
      static::request(),
      $expected,
    );
  }

  public function test_merge_short_circuits_when_one_match_is_found(): void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\merge(
        Lecof\null(),
        Lecof\null(),
        Lecof\done($expected),
        Lecof\unreachable('Must Lecof\done($expected)'),
      ),
      static::request(),
      $expected,
    );
  }
}
