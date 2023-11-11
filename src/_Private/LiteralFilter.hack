/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class LiteralFilter<+T> implements LecofInterfaces\Filter<T> {
  public function __construct(
    private string $literal,
    private LecofInterfaces\Filter<T> $next,
  )[] {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  )[self::CTX]: ?LecofInterfaces\RouteResult<T> {
    if ($request_info->getPathSegment($index) !== $this->literal) {
      return null;
    }

    return $this->next->filter($request_info, $index + 1);
  }
}
