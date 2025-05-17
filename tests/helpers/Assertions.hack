/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HH\Lib\{Dict, PseudoRandom};
use namespace HTL\LecofInterfaces;
use type Facebook\HackTest\HackTest;
use function HTL\Expect\expect;

trait Assertions {
  require extends HackTest;

  protected static function assertBails(
    LecofInterfaces\Filter<mixed> $filter,
    LecofInterfaces\RequestInfo $request_info,
  )[defaults]: void {
    expect($filter->filter($request_info, 0))->toBeNull();
  }

  protected static function assertHasVariables(
    LecofInterfaces\Filter<mixed> $filter,
    LecofInterfaces\RequestInfo $request_info,
    dict<string, mixed> $variables,
  )[defaults]: void {
    $result = $filter->filter($request_info, 0);
    expect($result)->toBeNonnull();
    expect(Dict\pull(
      $result as nonnull[1],
      $var ==> $var->getValue(),
      $var ==> $var->getName(),
    ))->toHaveSameContentAs($variables);
  }

  protected static function assertReturns(
    LecofInterfaces\Filter<mixed> $filter,
    LecofInterfaces\RequestInfo $request_info,
    mixed $expected,
  )[defaults]: void {
    $result = $filter->filter($request_info, 0);
    expect($result)->toBeNonnull();
    expect($result as nonnull[0])->toEqual($expected);
  }

  protected static function assertThrowsExactType(
    LecofInterfaces\Filter<nonnull> $filter,
    LecofInterfaces\RequestInfo $request_info,
    classname<\Throwable> $exception_class,
    string $message,
  )[defaults]: void {
    try {
      $filter->filter($request_info, 0);
    } catch (\Throwable $t) {
      expect(\get_class($t))->toEqual($exception_class);
      expect($t->getMessage())->toContainSubstring($message);
    }
  }

  protected static function request(
    ?string $path = null,
  )[]: LecofInterfaces\RequestInfo {
    return new RequestInfo($path ?? '/');
  }

  protected static function rand()[defaults]: int {
    return PseudoRandom\int();
  }
}
