/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * Resolves to $done if the path has been exhausted, null if it is not.
 */
function done<T>(T $done)[]: LecofInterfaces\Filter<T> {
  return new _Private\DoneFilter($done);
}
