/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class SlashedLiteralFilter<+T> implements LecofInterfaces\Filter<T> {
  public function __construct(
    private string $literal,
    private LecofInterfaces\Filter<T> $next,
  ) {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  ): ?LecofInterfaces\RouteResult<T> {
    if (!$request_info->hasPathSegment($index)) {
      return null;
    }

    if ($request_info->getPathSegmentsAsString($index) !== $this->literal) {
      return null;
    }

    return $this->next->filter($request_info, $request_info->getPathLength());
  }
}
