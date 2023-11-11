/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HH\Lib\C;
use namespace HTL\LecofInterfaces;

final class SlashedLiteralsFilter<+T> implements LecofInterfaces\Filter<T> {
  public function __construct(
    private dict<string, LecofInterfaces\Filter<T>> $children,
  )[] {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  )[self::CTX]: ?LecofInterfaces\RouteResult<T> {
    if (!$request_info->hasPathSegment($index)) {
      return null;
    }

    $segment = $request_info->getPathSegmentsAsString($index);
    if (!C\contains_key($this->children, $segment)) {
      return null;
    }

    return $this->children[$segment]->filter(
      $request_info,
      $request_info->getPathLength(),
    );
  }
}
