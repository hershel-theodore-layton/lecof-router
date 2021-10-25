/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof\_Private;

// The type of a `T ... $param` for the current hhvm version.
// In hhvm versions where variadics are backed by vecs, this statement
// conveniently reads `type variadic<T> = vec<T>;`.
type variadic<T> = varray<T>;
