/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;

/**
 * Consumes all the unconsumed path segments and calls `->filter()` on $next.
 */
function ignore_trailing_path<T>(
  LecofInterfaces\Filter<T> $next,
)[]: LecofInterfaces\Filter<T> {
  return new _Private\IgnoreTrailingPathFilter($next);
}
