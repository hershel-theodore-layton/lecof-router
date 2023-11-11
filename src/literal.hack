/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * Matching a single path segment case sensitively.
 * Do not prefix $literal with a slash: use `api`, NOT `/api`.
 */
function literal<T>(
  string $literal,
  LecofInterfaces\Filter<T> $next,
)[]: LecofInterfaces\Filter<T> {
  return new _Private\LiteralFilter($literal, $next);
}
