/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HH\Lib\{Dict, PseudoRandom};
use namespace HTL\LecofInterfaces;
use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;

trait Assertions {
  require extends HackTest;

  protected static function assertBails<T as nonnull>(
    LecofInterfaces\Filter<T> $filter,
    LecofInterfaces\RequestInfo $request_info,
  ): void {
    expect($filter->filter($request_info, 0))->toBeNull();
  }

  protected static function assertDoesNotChangeIndex<T as nonnull>(
    LecofInterfaces\Filter<T> $filter,
    LecofInterfaces\RequestInfo $request_info,
    DoYouRemember<T> $memory,
  ): void {
    $expected = static::rand();
    $filter->filter($request_info, $expected);
    expect($memory->index)->toEqual($expected);
  }

  protected static function assertExhaustsPath<T as nonnull>(
    LecofInterfaces\Filter<T> $filter,
    LecofInterfaces\RequestInfo $request_info,
    DoYouRemember<T> $memory,
    int $index = 0,
  ): void {
    $filter->filter($request_info, $index);
    expect($memory->index)->toEqual($request_info->getPathLength());
  }

  protected static function assertHasVariables<T as nonnull>(
    LecofInterfaces\Filter<T> $filter,
    LecofInterfaces\RequestInfo $request_info,
    dict<string, mixed> $variables,
  ): void {
    $result = $filter->filter($request_info, 0);
    $result =
      expect($result)->toNotBeNull('No variables, since routing returned null');
    expect(Dict\pull(
      $result[1],
      $var ==> $var->getValue(),
      $var ==> $var->getName(),
    ))->toHaveSameContentAs($variables);
  }

  protected static function assertIncrementsIndex<T as nonnull>(
    LecofInterfaces\Filter<T> $filter,
    LecofInterfaces\RequestInfo $request_info,
    DoYouRemember<T> $memory,
    int $index = 0,
  ): void {
    $filter->filter($request_info, $index);
    expect($memory->index)->toEqual($index + 1);
  }

  protected static function assertReturns<T as nonnull>(
    LecofInterfaces\Filter<T> $filter,
    LecofInterfaces\RequestInfo $request_info,
    T $expected,
  ): void {
    $result = $filter->filter($request_info, 0);
    list($return, $_) = expect($result)->toNotBeNull('Routing returned null');
    expect($return)->toEqual($expected);
  }

  protected static function assertThrowsExactType<T as nonnull>(
    LecofInterfaces\Filter<T> $filter,
    LecofInterfaces\RequestInfo $request_info,
    classname<\Throwable> $exception_class,
    string $message,
  ): void {
    try {
      $filter->filter($request_info, 0);
    } catch (\Throwable $t) {
      expect(\get_class($t))->toEqual($exception_class);
      expect($t->getMessage())->toContainSubstring($message);
    }
  }

  protected static function request(
    ?string $path = null,
  ): LecofInterfaces\RequestInfo {
    return new RequestInfo($path ?? '/');
  }

  protected static function mem<T as nonnull>(
    LecofInterfaces\Filter<T> $next,
  ): (DoYouRemember<T>, LecofInterfaces\Filter<T>) {
    $memory = new DoYouRemember();
    return tuple($memory, remember($memory, $next));
  }

  protected static function rand(): int {
    return PseudoRandom\int();
  }
}
