/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;

/**
 * @deprecated consumes a path segment, use add_variable. If you depend on the
 * skipping of the path segment, use add_variable_skip_path_segment to make your
 * intent clear.
 */
function inject_variable<T>(
  LecofInterfaces\ParsedVariable<mixed> $variable,
  LecofInterfaces\Filter<T> $next,
)[]: LecofInterfaces\Filter<T> {
  return add_variable_skip_path_segment($variable, $next);
}
