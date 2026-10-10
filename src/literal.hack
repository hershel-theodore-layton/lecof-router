/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;

/**
 * Matching a single path segment (case-sensitive).
 * $literal is decoded segment text: `a/b` matches `/a%2Fb`, not `/a/b`.
 * A leading slash in $literal is segment content, not a path separator.
 * For `/api`, use `api`, not `/api`.
 */
function literal<T>(
  string $literal,
  LecofInterfaces\Filter<T> $next,
)[]: LecofInterfaces\Filter<T> {
  return new _Private\LiteralFilter($literal, $next);
}
