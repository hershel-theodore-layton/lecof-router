/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HH\Lib\{Dict, PseudoRandom};
use namespace HTL\LecofInterfaces;
use function HTL\Expect\{expect, expect_invoked};
use type Throwable;

final class Assertions {
  public function assertBails(
    LecofInterfaces\Filter<mixed> $filter,
    LecofInterfaces\RequestInfo $request_info,
  )[]: void {
    expect($filter->filter($request_info, 0))->toBeNull();
  }

  public function assertHasVariables(
    LecofInterfaces\Filter<mixed> $filter,
    LecofInterfaces\RequestInfo $request_info,
    dict<string, mixed> $variables,
  )[]: void {
    $result = $filter->filter($request_info, 0);
    expect($result)->toBeNonnull();
    expect(Dict\pull(
      $result as nonnull[1],
      $var ==> $var->getValue(),
      $var ==> $var->getName(),
    ))->toHaveSameContentAs($variables);
  }

  public function assertReturns(
    LecofInterfaces\Filter<mixed> $filter,
    LecofInterfaces\RequestInfo $request_info,
    mixed $expected,
  )[]: void {
    $result = $filter->filter($request_info, 0);
    expect($result)->toBeNonnull();
    expect($result as nonnull[0])->toEqual($expected);
  }

  public function assertThrowsExactType<<<__Enforceable>> reify T as Throwable>(
    LecofInterfaces\Filter<nonnull> $filter,
    LecofInterfaces\RequestInfo $request_info,
    string $message,
  )[]: void {
    expect_invoked(() ==> $filter->filter($request_info, 0))->toHaveThrown<T>(
      $message,
    );
  }

  public function request(?string $path = null)[]: LecofInterfaces\RequestInfo {
    return new RequestInfo($path ?? '/');
  }

  public function rand()[defaults]: int {
    return PseudoRandom\int();
  }
}
