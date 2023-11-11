/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class ParseVariableFilterTest extends HackTest {
  use Assertions;

  public function test_forwards_when_the_parser_can_parse(): void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\parse_variable(
        new AnythingGoesParser('var'),
        Lecof\done($expected),
      ),
      static::request('/anything'),
      $expected,
    );
  }

  public function test_bails_when_the_parser_can_not_parse(): void {
    static::assertBails(
      Lecof\parse_variable(new FailingParser(), Lecof\done(42)),
      static::request('/fails'),
    );
  }

  public function test_variables_are_parsed(): void {
    static::assertHasVariables(
      Lecof\parse_variable(new StringReverseParser('var'), Lecof\done(42)),
      static::request('/esrever'),
      dict['var' => 'reverse'],
    );
  }

  public function test_variables_from_a_nested_filter_are_retained(): void {
    static::assertHasVariables(
      Lecof\parse_variable(
        new StringReverseParser('outer'),
        Lecof\parse_variable(new StringReverseParser('inner'), Lecof\done(42)),
      ),
      static::request('/retuo/54321'),
      dict['outer' => 'outer', 'inner' => '12345'],
    );
  }
}
