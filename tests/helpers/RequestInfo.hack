/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HH\Lib\{C, Str, Vec};
use namespace HTL\LecofInterfaces;

final class RequestInfo implements LecofInterfaces\RequestInfo {
  private vec<string> $segments;

  public function __construct(string $path) {
    $this->segments = Str\strip_prefix($path, '/')
      |> Str\split($$, '/')
      |> $$ === vec[''] ? vec[] : $$;
  }

  public function getByType<reify T>(): nothing {
    invariant_violation('No extensions available');
  }

  public function getByTypex<reify T>(): nothing {
    invariant_violation('No extensions available');
  }

  public function getPathLength(): int {
    return C\count($this->segments);
  }

  public function getPathSegment(int $index): ?string {
    return $this->segments[$index] ?? null;
  }

  <<__Memoize>>
  public function getPathSegments(
    int $start = 0,
    ?int $length = null,
  ): vec<string> {
    if ($length is null || $length >= $this->getPathLength()) {
      return
        $start === 0 ? $this->segments : Vec\slice($this->segments, $start);
    } else {
      return Vec\slice($this->segments, $start, $length);
    }
  }

  <<__Memoize>>
  public function getPathSegmentsAsString(
    int $start = 0,
    ?int $length = null,
  ): string {
    return Str\join($this->getPathSegments($start, $length), '/');
  }
  public function getPathSegmentx(int $index): string {
    return $this->segments[$index];
  }

  public function hasPathSegment(int $index): bool {
    return C\contains_key($this->segments, $index);
  }

  public function pathHasBeenExhausted(int $index): bool {
    return !$this->hasPathSegment($index);
  }
}
