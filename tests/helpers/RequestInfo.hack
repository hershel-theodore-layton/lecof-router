/**
 * You are encouraged to copy paste this file and change it to meet your needs.
 * From the moment you make a single edit to this file, f.e. a change to the
 * namespace name, your version of this file becomes yours and yours alone.
 * The unedited original remains licensed under MIT-0.
 * This license text is included at the bottom of this file.
 *
 * The license at the end of this file applies to this file and this file alone.
 * The license of the other files in this project remains unaffected.
 */

namespace HTL\Lecof\Tests;

use namespace HH\Lib\{C, Str, Vec};
use namespace HTL\LecofInterfaces;

final class RequestInfo implements LecofInterfaces\RequestInfo {
  private vec<string> $segments;

  public function __construct(string $path)[] {
    $this->segments = Str\strip_prefix($path, '/')
      |> Str\split($$, '/')
      |> $$ === vec[''] ? vec[] : $$;
  }

  public function getByType<reify T>()[]: nothing {
    invariant_violation('No extensions available');
  }

  public function getByTypex<reify T>()[]: nothing {
    invariant_violation('No extensions available');
  }

  public function getPathLength()[]: int {
    return C\count($this->segments);
  }

  public function getPathSegment(int $index)[]: ?string {
    return $this->segments[$index] ?? null;
  }

  <<__Memoize>>
  public function getPathSegments(
    int $start = 0,
    ?int $length = null,
  )[]: vec<string> {
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
  )[]: string {
    return Str\join($this->getPathSegments($start, $length), '/');
  }
  public function getPathSegmentx(int $index)[]: string {
    return $this->segments[$index];
  }

  public function hasPathSegment(int $index)[]: bool {
    return C\contains_key($this->segments, $index);
  }

  public function pathHasBeenExhausted(int $index)[]: bool {
    return !$this->hasPathSegment($index);
  }
}

/*
 * This license notice NEED NOT be preserved.
 *                     ^^^^^^^^
 * MIT No Attribution
 * 
 * Copyright 2024 Hershel Theodore Layton
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
