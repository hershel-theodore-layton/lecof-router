/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\Tests;

use namespace HTL\{Lecof, TestChain};

<<TestChain\Discover>>
function slashed_literal_filter_test(
  TestChain\Chain $chain,
)[]: TestChain\Chain {
  $assert = new Assertions();

  return $chain->group(__FUNCTION__)
    ->test('test_forwards_when_literal_is_same', ()[defaults] ==> {
      $expected = $assert->rand();
      $assert->assertReturns(
        Lecof\slashed_literal('hello', Lecof\done($expected)),
        $assert->request('/hello'),
        $expected,
      );
    })
    ->test('test_bails_when_literal_is_different', ()[defaults] ==> {
      $expected = $assert->rand();
      $assert->assertBails(
        Lecof\slashed_literal('hi', Lecof\done($expected)),
        $assert->request('/hello'),
      );
    })
    ->test('test_forwards_when_rest_matches', ()[defaults] ==> {
      $expected = $assert->rand();
      $assert->assertReturns(
        Lecof\slashed_literal('very/many/parts', Lecof\done($expected)),
        $assert->request('/very/many/parts'),
        $expected,
      );
    })
    ->test('test_bails_when_one_part_of_rest_is_different', ()[defaults] ==> {
      $expected = $assert->rand();
      $assert->assertBails(
        Lecof\slashed_literal('very/many/parts', Lecof\done($expected)),
        $assert->request('/very/few/parts'),
      );
    })
    ->testWith2Params(
      'test_bails_when_decoding_would_change_segment_boundaries',
      () ==> dict[
        '/a%2Fb' => tuple('/a%2Fb', 'a/b'),
        '/a%2fb' => tuple('/a%2fb', 'a/b'),
        '/a%2F/b' => tuple('/a%2F/b', 'a//b'),
        '/%2F' => tuple('/%2F', '/'),
      ],
      (string $path, string $pattern) ==> {
        $assert->assertBails(
          Lecof\slashed_literal($pattern, Lecof\done(42)),
          $assert->request($path),
        );
      },
    )
    ->testWith2Params(
      'test_forwards_when_decoded_segments_match',
      () ==> dict[
        '/a/b' => tuple('/a/b', 'a/b'),
        '/a//b' => tuple('/a//b', 'a//b'),
        '/%30' => tuple('/%30', '0'),
        '/a%252Fb' => tuple('/a%252Fb', 'a%2Fb'),
        '/a/b/' => tuple('/a/b/', 'a/b/'),
      ],
      (string $path, string $pattern) ==> {
        $assert->assertReturns(
          Lecof\slashed_literal($pattern, Lecof\done(42)),
          $assert->request($path),
          42,
        );
      },
    )
    ->test('test_bails_on_a_partial_match', ()[defaults] ==> {
      $expected = $assert->rand();
      $assert->assertBails(
        Lecof\slashed_literal('very/many', Lecof\done($expected)),
        $assert->request('/very/many/parts'),
      );
    });
}
