/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * An optimized version of merging multiple consecutive `literal()` calls.
 * `Lecof\merge(Lecof\literal('a', ...), Lecof\literal('b', ...))` is equivalent
 * to `Lecof\literals(dict['a' => ..., 'b' => ...])`.
 * Do not prefix $literal with a slash: use `api`, NOT `/api`.
 */
function literals<T>(
  dict<string, LecofInterfaces\Filter<T>> $children,
): LecofInterfaces\Filter<T> {
  return new _Private\LiteralsFilter($children);
}
