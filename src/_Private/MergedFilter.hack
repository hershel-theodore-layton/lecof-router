/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class MergedFilter<+T> implements LecofInterfaces\Filter<T> {
  public function __construct(
    private LecofInterfaces\Filter<T> $first,
    private variadic<LecofInterfaces\Filter<T>> $rest,
  ) {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  ): ?LecofInterfaces\RouteResult<T> {
    $result = $this->first->filter($request_info, $index);
    if ($result is nonnull) {
      return $result;
    }

    foreach ($this->rest as $filter) {
      $result = $filter->filter($request_info, $index);
      if ($result is nonnull) {
        return $result;
      }
    }

    return null;
  }
}
