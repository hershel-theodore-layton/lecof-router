/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

use namespace HTL\LecofInterfaces;

final class ParseVariableFilter<+T> implements LecofInterfaces\Filter<T> {
  public function __construct(
    private LecofInterfaces\VariableParser<mixed> $parser,
    private LecofInterfaces\Filter<T> $next,
  ) {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  ): ?LecofInterfaces\RouteResult<T> {
    if (!$request_info->hasPathSegment($index)) {
      return null;
    }

    $path_segment = $request_info->getPathSegmentx($index);
    if (!$this->parser->canParse($path_segment)) {
      return null;
    }

    $return = $this->next->filter($request_info, $index + 1);
    if ($return is null) {
      return null;
    }

    $return[1][] = $this->parser->parse($path_segment);
    return $return;
  }
}
