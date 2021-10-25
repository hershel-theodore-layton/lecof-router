/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class DoneFilter<T as nonnull> implements LecofInterfaces\Filter<T> {

  public function __construct(private T $done) {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  ): ?LecofInterfaces\RouteResult<T> {
    if (!$request_info->pathHasBeenExhausted($index)) {
      return null;
    }

    return tuple($this->done, vec[]);
  }
}
