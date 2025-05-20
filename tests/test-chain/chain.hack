/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Project_4PwQUZ8GatbO\GeneratedTestChain;

use namespace HTL\TestChain;

async function tests_async<T as TestChain\Chain>(
  TestChain\ChainController<T> $controller
)[defaults]: Awaitable<TestChain\ChainController<T>> {
  return $controller
    ->addTestGroup(\HTL\Lecof\Tests\done_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\ignore_trailing_path_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\inject_variable_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\lazy_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\literal_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\literals_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\merged_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\null_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\parse_variable_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\slashed_literal_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\slashed_literals_filter_test<>)
    ->addTestGroup(\HTL\Lecof\Tests\unreachable_filter_test<>);
}
