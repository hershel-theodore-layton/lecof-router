/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\LecofInterfaces;

function remember<T>(
  DoYouRemember<T> $the_21st_night_of_september,
  LecofInterfaces\Filter<T> $next,
): LecofInterfaces\Filter<T> {
  return new Remember($the_21st_night_of_september, $next);
}

final class DoYouRemember<T> {
  public ?LecofInterfaces\RequestInfo $requestInfo;
  public ?int $index;
  public ?LecofInterfaces\RouteResult<T> $return;
  public ?\Throwable $thrown;
}

final class Remember<+T> implements LecofInterfaces\Filter<T> {
  public function __construct(
    private DoYouRemember<T> $memory,
    private LecofInterfaces\Filter<T> $next,
  )[] {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  ): ?LecofInterfaces\RouteResult<T> {
    $this->memory->requestInfo = $request_info;
    $this->memory->index = $index;

    try {
      $return = $this->next->filter($request_info, $index);
      $this->memory->return = $return;
      return $return;
    } catch (\Throwable $t) {
      $this->memory->thrown = $t;
      throw $t;
    }
  }
}
