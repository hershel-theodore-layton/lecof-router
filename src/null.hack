/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * A Filter that always returns null when routed to.
 * This is not a dead end, it does NOT act as an explicit 404.
 */
function null(): LecofInterfaces\Filter<nothing> {
  return new _Private\NullFilter();
}
