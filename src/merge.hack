/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HH\Lib\C;
use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * Glue two or more filters together.
 * ```
 * Lecof\merge(
 *   Lecof\literal('me', Lecof\done(get_profile_of_current_user<>)),
 *   Lecof\parse_variable(
 *     new UsernameVariable('user_name'),
 *     Lecof\done(get_profile_by_user_name<>),
 *   )
 * );
 * ```
 */
function merge<T>(
  LecofInterfaces\Filter<T> $first,
  LecofInterfaces\Filter<T> ...$rest
): LecofInterfaces\Filter<T> {
  return C\is_empty($rest) ? $first : new _Private\MergedFilter($first, $rest);
}
