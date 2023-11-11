/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\LecofInterfaces;

final class FailingParser implements LecofInterfaces\VariableParser<string> {
  public function canParse(string $_raw)[]: bool {
    return false;
  }

  public function parse(string $raw)[]: nothing {
    invariant_violation('Could not parse %s', $raw);
  }
}
