/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class UnreachableFilter<T as nonnull>
  implements LecofInterfaces\Filter<T> {

  public function __construct(
    private string $format,
    private variadic<mixed> $args,
  ) {}

  public function filter(
    LecofInterfaces\RequestInfo $_request_info,
    int $_index,
  ): nothing {
    throw new InvariantException(\vsprintf($this->format, $this->args));
  }
}
