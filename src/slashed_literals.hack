/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;

/**
 * An optimized form of merging multiple consecutive `slashed_literal()` calls.
 * `Lecof\merge(Lecof\slashed_literal('a/b', ...), Lecof\slashed_literal('c/d', ...))`
 * is equivalent to `Lecof\slashed_literals(dict['a/b' => ..., 'c/d' => ...])`.
 * Keys use the same decoded segment values and `/` separators as
 * `slashed_literal()`. A slash inside a segment cannot match a separator.
 */
function slashed_literals<T>(
  dict<string, LecofInterfaces\Filter<T>> $children,
)[]: LecofInterfaces\Filter<T> {
  return new _Private\SlashedLiteralsFilter($children);
}
