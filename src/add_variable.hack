/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;

/**
 * Adds a variable without consuming a path segment
 * and calls `->filter()` on $next.
 */
function add_variable<T>(
  LecofInterfaces\ParsedVariable<mixed> $variable,
  LecofInterfaces\Filter<T> $next,
)[]: LecofInterfaces\Filter<T> {
  return new _Private\AddVariableFilter($variable, $next, 0);
}
