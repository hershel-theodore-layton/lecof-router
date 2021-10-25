/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class LazyFilter<T as nonnull> implements LecofInterfaces\Filter<T> {
  public function __construct(
    private (function(): LecofInterfaces\Filter<T>) $next,
  ) {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  ): ?LecofInterfaces\RouteResult<T> {
    return ($this->next)()->filter($request_info, $index);
  }
}
