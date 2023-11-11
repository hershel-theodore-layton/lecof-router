/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class LazyFilter<+T> implements LecofInterfaces\Filter<T> {
  public function __construct(
    private (function()[self::CTX]: LecofInterfaces\Filter<T>) $next,
  )[] {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  )[self::CTX]: ?LecofInterfaces\RouteResult<T> {
    return ($this->next)()->filter($request_info, $index);
  }
}
