/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HH\Lib\Str;
use namespace HTL\LecofInterfaces;

final class SlashedLiteralFilter<+T> implements LecofInterfaces\Filter<T> {
  private vec<string> $segments;

  public function __construct(
    string $literal,
    private LecofInterfaces\Filter<T> $next,
  )[] {
    $this->segments = Str\split($literal, '/');
  }

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  )[self::CTX]: ?LecofInterfaces\RouteResult<T> {
    if (!$request_info->hasPathSegment($index)) {
      return null;
    }

    if ($request_info->getPathSegments($index) !== $this->segments) {
      return null;
    }

    return $this->next->filter($request_info, $request_info->getPathLength());
  }
}
