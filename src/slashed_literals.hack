/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * An optimized form of merging multiple consecutive `slashed_literal()` calls.
 * `Lecof\merge(Lecof\slashed_literal('a/b', ...), Lecof\literal('c/d', ...))`
 * is equivalent to `Lecof\slashed_literals(dict['a/b' => ..., 'c/d' => ...])`.
 */
function slashed_literals<T>(
  dict<string, LecofInterfaces\Filter<T>> $children,
)[]: LecofInterfaces\Filter<T> {
  return new _Private\SlashedLiteralsFilter($children);
}
