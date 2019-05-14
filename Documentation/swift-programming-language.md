# Swift

## `NULL` vs. `nil`
* Technically they are both 0.
* Use `NULL` when you are working with pointers in C or C++.
* Use `nil` when you are working with an objc object. 

---


* What does `@objc` do?
* Functional programming in swift.
	* `[].filter`
	* `[].map`

## Big picture
* Swift follows `go` (and is followed by Kotlin) in continuing the trend of safe, statically typed languages that feels like a dynamic scripting language.
* Swift's REPL is a playground.

## Questions
* What is the swift global scope?
* What is included in global scope?
* How to create immutable classes? Getters only? 
* Try extensions. 
* What platforms are 32 bit vs 64 bit?
* Create your own operator. Possible?
* How to create an objective-c module that can be imported in swift?
* What is the swift standard library? What is in it?
* Strings and extended grapheme clusters. (Olé)

* Protocols and extension examples.
* Extended graphene clusters.
* Collection types - functional usage.
* Switch pattern matching.
* Functional libraries for swift.

## Likes
* The principles
	* Safe, modern, fast.
	* Immutable tendencies (let).
* Safe
	* Type system
	* Strongly typed / type inference.
	* Structs and enums are real types.
	* Generics.
	* Conditionals must be a boolean expression.
	* Method parameter names are required (2nd parameter or greater). Self documenting.
	* You must specify “override” if you are overriding a function. You can’t accidentally override a function.
	* No implicit type conversion or type cohesion.
	* Initialization. Requires all stored properties to be set in `init`. 
		* No partially initialized objects.

* Modern
	* Optionals. Even traditionally primitive types.
	* String interpolation.
	* Pattern matching. Case statement is vastly improved from C. Pattern matching / variable assignment is awesome.
	* No preprocessor! No macros!
	* Enums - associated values.
	* Tuples

* Fast
	* Automatic memory management, no GC.

## Assertions / Preconditions
```
assert(bool, msg)
assertionFailure(msg)

// Preconditions are checked in Debug *and* Release builds.
precondition(bool, msg)

// Only use during development
fatalError(msg)
```

## Access Control
### Goals
* Safe by design.
	* `public` must be explicitly marked to prevent accidental visibility. You must explicitly opt into `public`.
	* Access levels do not `leak`. 
		* You can’t expose member of a type with a more restrictive access level than the type in which it’s defined. 
			* e.g., An `internal` class can’t expose a `fileprivate` member.
		* Subclasses cannot have a higher access level than their parents.
		* Protocol inheritance cannot elevate the base protocol’s access level.
			* e.g., a `public` protocol cannot extend an `internal` protocol. 

### Access Control Rules
* Access control is based on modules and source files.
* Each build target (app bundle or framework) is a separate swift `module`.
* Multiple types can be defined per source file.  
	* *Remember : access control is per source file, not per type*

* Swift will ensure you can’t expose a private type via a public variable, or return a private type from a public function.
	* In both cases the visibility of the private type /may/ not be exposed to callers. 

* For typical apps, leaving types as `internal` is sufficient.
	* You are still encouraged to use `fileprivate` and `private` to encapsulate implementation details.
 
* A unit test target can access any internal entity by:
	* `@testable import MyApp`
	* Compile the test module with testing enabled. Test targets should already be setup with testing enabled.

* The default access level for a type member is the access level of it’s parent.
	* `public` is special.  Members of a `public`  type are `internal` by default.
	* *The swift general *

```
fileprivate class Foo {
  // `x` is `fileprivate`, **not** internal
  int x = 0
}
```

* Functions and tuples will have a calculated access level based on the types contained in the entity.  If the calculated access level for the tuple / function does not match the calculated value, you must explicitly declare the entity’s access level

```
// Will not compile. The default access level for `aFunc` is 
// `internal`, however it's calculated access level is
// `private`.
func aFunc() -> (InternalClass, PrivateClass)

// You must delcare `aFunc` as `private`
private func aFunc() -> (InternalClass, PrivateClass)
```
### Access Control Levels

* `open`  - can be subclassed by a class in an external module.
* `public`- visible to any module.
* `internal` - visible within the module.
* `fileprivate` - visible within the source file.
* `private` - visible within the entity *and extensions to that entity within the same source file*.

#### `open` vs `public`

> Marking a class as `open` explicitly indicates that you’ve considered the impact of code from other modules using that class as a superclass, and that you’ve designed your class’s code accordingly.

* Subclassing 
	* `open` allows subclassing from /any/ module.
	* `public` allows subclassing from the current module.

### Subclassing

* A subclass *can* call a superclass member that has a lower access level - as long as the call is within an allowed context (i.e., within the same source file for a `fileprivate` member.

```
public class A {
  fileprivate func someMethod() {}
}

internal class B : A {
  // someMethod() can be made more accessible from a subclass
  // The call to `super.someMethod()` is OK since we are
  // within an allowed context (fileprivate)
  override internal func someMethod() {
    super.someMethod()
  }
}
```

### Properties

* A setter can have a lower access level than the getter. 
```
struct TrackedString {
  [file]private(set) var numberOfEdits = 0
  var value: String = "" {
    didSet {
		numberOfEdits += 1
    }
  }
}
```

### Protocols

* All members of a protocol are the same access type as the protocol itself. 
* If the protocol is `public`, all members must be explicitly marked `public`.
* For each class that implements a protocol, each member implementation must at least have the same access level as the protocol itself.
```
protocol Calculatable {
  calculate() -> Int
}

// Both `Calculator` and `calculate` must be internal
// since `Calculatable` is internal.
class Calculator : Calculatable {
  func calculate() -> Int { }
}
```

### Extensions

* By default, extensions inherit the access level of the extended class.
* You can mark an extension with a lower access level to give a new default to members within the extension.
```
fileprivate class MyClass {
}

// `private` sets the default access level of all members
private extension MyClass {
  // implicitly private 
  func extend() -> (Int, Int)
}
```

* Private members in extensions.
	* You can declare a private member in the original declaration, and access that member from extensions in the same file.
	* Declare a `private` member in an extension, access it in another.
	* Declare a `private` member in an extension, access it from the original declaration.

## Links
* [The Swift Programming Language]([The Swift Programming Language (Swift 4): About Swift](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/index.html#//apple_ref/doc/uid/TP40014097-CH3-ID0)
