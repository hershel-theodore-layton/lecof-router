/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class UnreachableFilter implements LecofInterfaces\Filter<nothing> {
  public function __construct(
    private string $format,
    private vec<mixed> $args,
  )[] {}

  public function filter(
    LecofInterfaces\RequestInfo $_request_info,
    int $_index,
  )[self::CTX]: nothing {
    throw
      new InvariantException(\vsprintf($this->format, $this->args) as string);
  }
}
