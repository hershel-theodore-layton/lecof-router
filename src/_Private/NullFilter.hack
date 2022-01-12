/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class NullFilter implements LecofInterfaces\Filter<nothing> {
  public function filter(
    LecofInterfaces\RequestInfo $_request_info,
    int $_index,
  ): null {
    return null;
  }
}
