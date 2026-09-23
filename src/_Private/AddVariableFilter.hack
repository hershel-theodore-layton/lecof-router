/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class AddVariableFilter<+T> implements LecofInterfaces\Filter<T> {
  public function __construct(
    private LecofInterfaces\ParsedVariable<mixed> $variable,
    private LecofInterfaces\Filter<T> $next,
    private int $skipPathSegment,
  )[] {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  )[self::CTX]: ?LecofInterfaces\RouteResult<T> {
    $return = $this->next
      ->filter($request_info, $index + $this->skipPathSegment);
    if ($return is null) {
      return null;
    }

    $return[1][] = $this->variable;
    return $return;
  }
}
