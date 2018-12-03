# Objective-C

## Google Style Recommendations

* Provide Doxygen comments to all interface members.
  * @param, @return, @c

* Instance variables always start with `_`.

* Enum values should have names that extend the typedef name (for Swift
  interoperability)

```

typedef NS_ENUM(NSInteger, DisplayTinge) {
	DisplayTingeGreen = 1,
	DisplayTingeBlue = 2
};

```

* The recommended order for type declarations:
  * Properties
  * Class methods
  * Initializers
  * Instance methods.

* Avoid macros. Only macros that provide assertions or debug logging are allowed.

* Clearly identify your designated initializer.

* When deriving, implement *all* designated initializers from the
  superclass. Failing to do so may prevent your initializers from being called
  at all, leading to difficult to track down bugs.

* Do not use `new`, always use `[[Obj alloc] init]`.

* `import` Objc headers, `include` C and C++ headers. Using `import` on C / C++
  headers prevent future inclusions and could result in unintended compilation
  behavior.

* Order of #includes:
  * Related Header
  * Operating System Headers (@import Foundation)
    * Always use umbrella headers - not individual files. It's less work on the compiler.
  * Language Library Headers (#include <vector.h>)
  * Other Dependencies (#import "Utils/Classes/Map.h)

* Avoid messaging the current object during `init` and `dealloc`. Until the
  entire class hierarchy has had a chance to initialize, method invocation could
  result in a subclass method operating on uninitialized state.

* Always prefer `copy` on properties (especially NSString).
* Use lightweight generics for all instance of NSArray, NSSet, NSDictionary.
* Use `__Nullable` and `__Nonnull` keywords over `__nullable` and `__nonnull`.
