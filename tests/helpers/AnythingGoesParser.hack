/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\LecofInterfaces;

final class AnythingGoesParser
  implements LecofInterfaces\VariableParser<string> {
  public function __construct(private string $name) {}
  public function canParse(string $_raw): bool {
    return true;
  }

  public function parse(string $raw): VariableHolder<string> {
    return new VariableHolder($this->name, $raw, $raw);
  }
}
