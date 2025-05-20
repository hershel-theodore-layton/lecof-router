/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function done_filter_test(TestChain\Chain $chain)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    ->test(
      'test_returns_what_it_has_been_given_if_path_has_been_exhausted',
      ()[defaults] ==> {
        $expect = $assert->rand();
        $assert->assertReturns(
          Lecof\done($expect),
          $assert->request(),
          $expect,
        );
      },
    )
    ->test('test_returns_null_if_path_has_not_been_exhausted', () ==> {
      $assert->assertBails(Lecof\done(5), $assert->request('/hi'));
    });
}
