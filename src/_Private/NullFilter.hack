/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class NullFilter<T as nonnull> implements LecofInterfaces\Filter<T> {

  public function filter(
    LecofInterfaces\RequestInfo $_request_info,
    int $_index,
  ): ?LecofInterfaces\RouteResult<T> {
    return null;
  }
}
