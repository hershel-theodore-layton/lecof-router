/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * An optimized version of concatenating multiple literal() calls which would
 * consume the entire path.
 * `Lecof\literal('a', Lecof\literal('b', Lecof\done(...)))` is equivalent to
 * `Lecof\slashed_literal('a/b', Lecof\done())`.
 * If the entire path would not be consumed by `slashed_literals()` null will
 * be returned. You can not do a partial match like:
 * `Lecof\slashed_literal('a/b', Lecof\literal('c', ...))`, since `a/b` would
 * fail to route at `Lecof\literal('c', ...)` and `a/b/c` would fail to route
 * at `Lecof\slashed_literal('a/b', ...)`.
 */
function slashed_literal<T>(
  string $literal,
  LecofInterfaces\Filter<T> $next,
): LecofInterfaces\Filter<T> {
  return new _Private\SlashedLiteralFilter($literal, $next);
}
