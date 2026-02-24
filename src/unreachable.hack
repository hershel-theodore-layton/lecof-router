/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HH\Lib\Str;
use namespace HTL\{HH4Shim, LecofInterfaces};
use namespace HTL\Lecof\_Private;

/**
 * The equivalent of an `invariant()` call which is executed when a subtree is
 * reached. This can be used when the filters merged before should have matched
 * all possible cases.
 * If you know that the http method in your part of this tree must be either
 * GET or POST, because of the places it is used in. It is wise to fail loudly
 * if your assumption proves to be incorrect at runtime.
 * ```
 * Lecof\merge(
 *   YourCode\get(...),
 *   YourCode\post(...),
 *   Lecof\unreachable('I was only expected to handle GET and POST'),
 * );
 * ```
 */
function unreachable(
  Str\SprintfFormatString $format,
  mixed ...$args
)[]: LecofInterfaces\Filter<nothing> {
  return new _Private\UnreachableFilter(HH4Shim\to_mixed($format) as string, $args);
}
