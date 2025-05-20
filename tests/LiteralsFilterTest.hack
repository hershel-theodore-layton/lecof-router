/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function literals_filter_test(TestChain\Chain $chain)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    ->test(
      'test_forwards_the_request_to_the_matching_literal',
      ()[defaults] ==> {
        $expected = $assert->rand();
        $assert->assertReturns(
          Lecof\literals(dict[
            'one' => Lecof\done(1),
            'two' => Lecof\done(2),
            'three' => Lecof\done($expected),
            'four' => Lecof\done(4),
          ]),
          $assert->request('/three'),
          $expected,
        );
      },
    )
    ->test('test_bails_when_none_of_the_literals_match', () ==> {
      $assert->assertBails(
        Lecof\literals(dict[
          'one' => Lecof\done(1),
          'two' => Lecof\done(2),
          'three' => Lecof\done(3),
          'four' => Lecof\done(4),
        ]),
        $assert->request('/five'),
      );
    })
    ->test('test_bails_when_dict_is_empty', () ==> {
      $assert->assertBails(Lecof\literals(dict[]), $assert->request('/five'));
    });
}
