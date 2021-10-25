# lecof-router

A request router for Hack and HHVM without a build step.

L.E.C.O.F. router
 - L. Lazily
 - E. Evaluated 
 - C. Composition 
 - O. Of
 - F. Filters

Pronounced as "Lack of router"

### Why Lecof Router?

This router avoids the need for a build step as a performance primitive by
using lazy evaluation. Constructing a full router for a complex application with
many endpoints can take longer than the actual routing itself. Codegen addresses
this issue by minimizing the amount of discovery that needs to be done on each
request. This trades in a nice developer experience for memory and cpu on the
server. I desperately want to reclaim the developer experience of adding a route
without delay or needing to remember to run the codegen. This tiny package
contains just enough primitives to allow you to express your routing needs in a
tree of nested function calls which execute on every request, whilst giving you
the means to make it fast. Any subtree can be replaced with a call to
`Lecof\lazy(function_returning_my_subtree<>)`, which defers the construction of
the subtree to the moment it is needed. If it is never needed, it does not get
constructed.

### Preparations for using and extending Lecof Router

You'll need to supply a class yourself and implement one interface in order to
get started with lecof-router:

A `RequestInfo` implementation is the only thing that is absolutely required.
This class knows how to get the request information in your current version of
hhvm. This class is intentionally not provided by this package, because this
is likely to change some time in the medium to far future. This is also the main
customization point. If you need to route based on IP, cookies, url parameters,
or something else, you can add it to your `RequestInfo` and access this
information through the `->getByType<T>()` api.

_Everything beyond this point is strictly optional. You basic use skip to [Usage](#Usage)_

If you wish to inject routing variables into your `RouteResult`, you must
provide an implementation of `ParsedVariable`. You can use `reify` and only use
a single class or use multiple classes, each one specialized for a different
type.

If you wish to parse routing variables from your `RouteResult`, you must
create an implementation of `VariableParser`, which knows how to turn raw text
into your `ParsedVariable` of choice.

Last but not least, this library is meant to be extended. If your needs are not
met by the included `Filter` classes, you can write your own in a a handful of
lines. Maybe you have a lot of endpoints that should be routed to without a file
extension like `/about`, but they need to keep working with an extension for
backwards compatibility. You can implement your own:

```HACK
function literal_with_optional_extension<T as nonnull>(
  string $literal,
  string $extension,
  LecofInterfaces\Filter<T> $next,
): LecofInterfaces\Filter<T> {
  return new LiteralWithOptionalExtension($literal, $extension, $next);
}

final class LiteralWithOptionalExtension<T as nonnull>
  implements LecofInterfaces\Filter<T> {

  public function __construct(
    private string $literal,
    private string $extension,
    private LecofInterfaces\Filter<T> $next,
  ) {}

  public function filter(
    LecofInterfaces\RequestInfo $request_info,
    int $index,
  ): ?LecofInterfaces\RouteResult<T> {
    $segment = $request_info->getPathSegment($index);
    if (
      $segment !== $this->literal &&
      $segment !== $this->literal.$this->extension
    ) {
      return null;
    }

    return $this->next->filter($request_info, $index + 1);
  }
}
```

### Usage

This example shows you what Lecof Router can do. The EntryPoint is probably
close the minimal starter. You may decide to change the signature of your
`MyEntryPointType` to better suit your needs. When migrating from an unrouted
`__EntryPoint` application, it may be beneficial to use
`(function(): Awaitable<void>)` for a while and dual purpose them as route
targets and `__EntryPoint` targets. You'll have to put the parsed information
into a static variable (just like `HH\\global_get()` is used).

```HACK
type RequestVariables = dict<string, LecofInterfaces\ParsedVariable<mixed>>;
type MyEntryPointType = (function(RequestVariables): Awaitable<void>);
type MyFilterType = LecofInterfaces\Filter<MyEntryPointType>;

<<__EntryPoint>>
async function my_web_entry_point_async(): Awaitable<void> {
  $request_info = get_my_request_info_from_globals();

  $router = Lecof\merge(
    // Index is very likely, so let's match it first.
    Lecof\done(web_index_async<>),
    // Only construct the /api subtree if we need it.
    Lecof\literal('api', Lecof\lazy(api_routes<>)),
    // Static resource not found, we can short circuit here.
    Lecof\literal('static', Lecof\done(four_oh_four_async<>)),
    Lecof\lazy(web_routes<>),
  );

  $default = tuple(four_oh_four_async<>, vec[]);
  list($route, $variables) = $router->filter($request_info, 0) ?? $default;
  await $route(Dict\from_values($variables, $v ==> $v->getName()));
}

// Some other file

function api_routes(): MyFilterType {
  return Lecof\literals(dict[
    'user' => Lecof\merge(
      Lecof\literal('me', Lecof\done(api_response_current_user_async<>)),
      Lecof\parse_variable(
        new IntegerParser('user_id'),
        Lecof\done(api_response_user_by_id_async<>),
      ),
    ),
    'users' => Lecof\merge(
      Lecof\inject_variable(
        new GenericParsedVariable<int>('page_number', '1', 1),
        Lecof\done(api_response_users_on_page_async<>),
      ),
      Lecof\parse_variable(
        new IntegerParser('page_number'),
        Lecof\done(api_response_users_on_page_async<>),
      ),
    ),
    // ...
  ]);
}

function web_routes(): MyFilterType {
  return Lecof\merge(
    Lecof\slashed_literals(dict[
      'about' => Lecof\done(web_about_async<>),
      'legal/privacy' => Lecof\done(web_privacy_async<>),
    ]),
    // ...
  );
}

// Another file

final class IntegerParser implements LecofInterfaces\VariableParser<int> {
  public function __construct(private string $name) {}
  public function canParse(string $raw): bool {
    return Str\to_int($raw) is nonnull;
  }
  public function parse(string $raw): LecofInterfaces\ParsedVariable<int> {
    return new GenericParsedVariable<int>(
      $this->name,
      $raw,
      Str\to_int($raw) as nonnull,
    );
  }
}

final class GenericParsedVariable<reify T>
  implements LecofInterfaces\ParsedVariable<T> {
  public function __construct(
    private string $name,
    private string $raw,
    private T $value,
  ) {}
  public function getName(): string {
    return $this->name;
  }
  public function getRawValue(): string {
    return $this->raw;
  }
  public function getValue(): T {
    return $this->value;
  }
}
```
