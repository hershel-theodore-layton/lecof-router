/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * Consumes a single path segment.
 * If the $parser can not parse the segment, null is returned.
 * Else the $next will be called.
 * If `$next->filter()` returns null, null is returned.
 * Else a `ParsedVariable` from `$parser->canParse()` is added to `RouteResult`.
 */
function parse_variable<T as nonnull>(
  LecofInterfaces\VariableParser<mixed> $parser,
  LecofInterfaces\Filter<T> $next,
): LecofInterfaces\Filter<T> {
  return new _Private\ParseVariableFilter($parser, $next);
}
