/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * Injects a variable without consuming a path segment
 * and calls `->filter()` on $next.
 */
function inject_variable<T>(
  LecofInterfaces\ParsedVariable<mixed> $variable,
  LecofInterfaces\Filter<T> $next,
)[]: LecofInterfaces\Filter<T> {
  return new _Private\InjectVariableFilter($variable, $next);
}
