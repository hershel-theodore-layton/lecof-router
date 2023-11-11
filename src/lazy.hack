/** lecof-router is MIT licensed, see /LICENSE. */
namespace HTL\Lecof;

use namespace HTL\LecofInterfaces;
use namespace HTL\Lecof\_Private;

/**
 * Calls $next (which constructs a subtree) and then calls `->filter()` on the
 * return value of $next;
 *
 * A powerful optimization primitive for large subtrees.
 * If the construction time of a routing tree becomes measurable, you can defer
 * and skip lot of object creation by creating a part you need when you need it.
 * By extracting a large subtree into a named free function and replacing the
 * subtree with `lazy(my_named_free_function<>)`, you don't construct objects
 * you don't need.
 * This is commonly most useful at the top-level of your tree.
 *
 * ```
 * $router = Lecof\merge(
 *   Lecof\literal('api', lazy(api_routes<>)),
 *   Lecof\lazy(web_routes<>),
 * );
 * ```
 *
 * If the route does not start with `/api`, `api_routes()` is never called.
 * If the route does start with `/api`, `api_routes()` is called first and only
 * if the `api_routes()` subtree can't route, will `web_routes()` be called.
 * This can cut the amount of object creation in half on every request.
 * Apply this optimization recursively until you have a speedy router again.
 *
 * Bonus tip: If `web_routes()` will never route anything `/api`-ish, you can
 * make `api_routes()` authoritative. You can short circuit the call to
 * `web_routes()` by throwing from the subtree in `api_routes()` or by returning
 * a dummy / 404 `RouteResult`.
 *
 * Side note: This is where this library got its name from. Lecof means:
 * "lazily evaluated composition of filters". I despised libraries which
 * constructed a complex router on every request. That is why I preferred
 * codegenned routers. The developer experience of waiting for the codegen was
 * worth the overhead of not having the construct thousands of objects. With
 * this primitive, you can have your cake (a good dev experience) and eat it too
 * (good runtime performance).
 */
function lazy<T>(
  (function()[LecofInterfaces\Filter::CTX]: LecofInterfaces\Filter<T>) $next,
)[]: LecofInterfaces\Filter<T> {
  return new _Private\LazyFilter($next);
}
