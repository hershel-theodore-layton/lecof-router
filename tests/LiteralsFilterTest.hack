/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class LiteralsFilterTest extends HackTest {
  use Assertions;

  public function test_forwards_the_request_to_the_matching_literal(): void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\literals(dict[
        'one' => Lecof\done(1),
        'two' => Lecof\done(2),
        'three' => Lecof\done($expected),
        'four' => Lecof\done(4),
      ]),
      static::request('/three'),
      $expected,
    );
  }

  public function test_bails_when_none_of_the_literals_match(): void {
    static::assertBails(
      Lecof\literals(dict[
        'one' => Lecof\done(1),
        'two' => Lecof\done(2),
        'three' => Lecof\done(3),
        'four' => Lecof\done(4),
      ]),
      static::request('/five'),
    );
  }

  public function test_bails_when_dict_is_empty(): void {
    static::assertBails(Lecof\literals(dict[]), static::request('/five'));
  }

  public function test_does_increment_index(): void {
    list($memory, $filter) = static::mem(Lecof\done(42));
    static::assertIncrementsIndex(
      Lecof\literals(dict[
        'one' => Lecof\done(1),
        'two' => Lecof\done(2),
        'three' => $filter,
        'four' => Lecof\done(4),
      ]),
      static::request('/three'),
      $memory,
    );
  }
}
