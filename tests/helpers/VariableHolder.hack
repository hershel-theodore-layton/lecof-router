/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\LecofInterfaces;

final class VariableHolder<T> implements LecofInterfaces\ParsedVariable<T> {
  public function __construct(
    private string $name,
    private string $rawValue,
    private T $parsedValue,
  ) {}

  public function getName(): string {
    return $this->name;
  }

  public function getRawValue(): string {
    return $this->rawValue;
  }

  public function getValue(): T {
    return $this->parsedValue;
  }
}
