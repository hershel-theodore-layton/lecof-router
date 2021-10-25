/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * Consumes all the unconsumed path segments and calls `->filter()` on $next.
 */
function ignore_trailing_path<T as nonnull>(
  LecofInterfaces\Filter<T> $next,
): LecofInterfaces\Filter<T> {
  return new _Private\IgnoreTrailingPathFilter($next);
}
