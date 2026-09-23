/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;

/**
 * Adds a variable, skips a path segment, and calls `->filter()` on $next.
 * Preserves the behavior of `inject_variable()`.
 */
function add_variable_skip_path_segment<T>(
  LecofInterfaces\ParsedVariable<mixed> $variable,
  LecofInterfaces\Filter<T> $next,
)[]: LecofInterfaces\Filter<T> {
  return new _Private\AddVariableFilter($variable, $next, 1);
}
