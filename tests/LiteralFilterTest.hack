/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function literal_filter_test(TestChain\Chain $chain)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    ->test('test_forwards_when_literal_is_same', ()[defaults] ==> {
      $expected = $assert->rand();
      $assert->assertReturns(
        Lecof\literal('hello', Lecof\done($expected)),
        $assert->request('/hello'),
        $expected,
      );
    })
    ->test('test_bails_when_literal_is_different', ()[defaults] ==> {
      $expected = $assert->rand();
      $assert->assertBails(
        Lecof\literal('hi', Lecof\done($expected)),
        $assert->request('/hello'),
      );
    })
    ->test(
      'test_rejects_requests_when_you_specify_a_leading_slash',
      ()[defaults] ==> {
        $expected = $assert->rand();
        $assert->assertBails(
          Lecof\literal('/hello', Lecof\done($expected)),
          // DON'T SAY / ^^^^^^
          $assert->request('/hello'),
        );
      },
    );
}
