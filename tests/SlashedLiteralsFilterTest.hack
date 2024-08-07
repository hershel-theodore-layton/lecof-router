/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class SlashedLiteralsFilterTest extends HackTest {
  use Assertions;

  public function test_forwards_the_request_to_the_matching_literal(
  )[defaults]: void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\slashed_literals(dict[
        'one' => Lecof\done(1),
        'two' => Lecof\done(2),
        'three' => Lecof\done($expected),
        'four' => Lecof\done(4),
      ]),
      static::request('/three'),
      $expected,
    );
  }

  public function test_bails_when_none_of_the_literals_match()[defaults]: void {
    static::assertBails(
      Lecof\slashed_literals(dict[
        'one' => Lecof\done(1),
        'two' => Lecof\done(2),
        'three' => Lecof\done(3),
        'four' => Lecof\done(4),
      ]),
      static::request('/five'),
    );
  }

  public function test_bails_when_dict_is_empty()[defaults]: void {
    static::assertBails(
      Lecof\slashed_literals(dict[]),
      static::request('/five'),
    );
  }

  public function test_forwards_the_request_to_the_matching_slashed_literal(
  )[defaults]: void {
    $expect = static::rand();
    static::assertReturns(
      Lecof\slashed_literals(dict[
        'a/b/c/g' => Lecof\done(1),
        'a/b/d/g' => Lecof\done(2),
        'a/b/e/g' => Lecof\done($expect),
        'a/b/f/g' => Lecof\done(4),
      ]),
      static::request('/a/b/e/g'),
      $expect,
    );
  }

  public function test_bails_on_a_partial_match()[defaults]: void {
    static::assertBails(
      Lecof\slashed_literals(dict[
        'a/b/c/g' => Lecof\done(1),
        'a/b/d/g' => Lecof\done(2),
        'a/b/e/g' => Lecof\done(3),
        'a/b/f/g' => Lecof\done(4),
      ]),
      static::request('/a/b/c/g/l'),
    );
  }
}
