/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\Lecof;
use type Facebook\HackTest\HackTest;

final class InjectVariableFilterTest extends HackTest {
  use Assertions;

  public function test_returns_the_value_of_the_inner_filter(): void {
    $expected = static::rand();
    static::assertReturns(
      Lecof\inject_variable(
        new VariableHolder('var', 'hi', 'hello'),
        Lecof\done($expected),
      ),
      static::request('/anything'),
      $expected,
    );
  }

  public function test_bails_if_inner_bails(): void {
    static::assertBails(
      Lecof\inject_variable(
        new VariableHolder('var', 'meh', '_'),
        Lecof\null(),
      ),
      static::request('/hello'),
    );
  }

  public function test_bails_when_the_parser_can_not_parse(): void {
    static::assertHasVariables(
      Lecof\inject_variable(
        new VariableHolder('var', 'hi', 'hello'),
        Lecof\done(42),
      ),
      static::request('/anything'),
      dict['var' => 'hello'],
    );
  }

  public function test_variables_from_a_nested_filter_are_retained(): void {
    static::assertHasVariables(
      Lecof\inject_variable(
        new VariableHolder('outer', 'letters', 'abc'),
        Lecof\inject_variable(
          new VariableHolder('inner', 'numbers', '123'),
          Lecof\done(42),
        ),
      ),
      static::request('/retuo/54321'),
      dict['outer' => 'abc', 'inner' => '123'],
    );
  }
}
