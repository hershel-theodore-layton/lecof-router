/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class IgnoreTrailingPathFilter<+T> implements LecofInterfaces\Filter<T> {
  public function __construct(private LecofInterfaces\Filter<T> $next) {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $_index,
  ): ?LecofInterfaces\RouteResult<T> {
    return $this->next->filter($request_info, $request_info->getPathLength());
  }
}
