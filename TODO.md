# Swift TODO

* Remove `open` from tests.
* Review tests for optionals (chaining).
* Why did swift decide to use both argument labels and parameter names for function parameters?

## Language

* Type system
    * What is `Any` and `AnyObject`?

* Memory management
    * Parent -> Child relationships typically uses a strong reference.
    * Child -> Parent relationships use `weak` or `unowned`.
    * `weak` can be nil. (Must be optional variables)
    * `unowned` cannot be nil.

    * In capture lists, when to use `weak` or `unowned`?

* Extensions

* `class` vs. `struct`
    * Class == pass by reference
    * Struct == pass by value. Do not support inheritance.
    * Consider defining small data structures as `struct`, larger data structures as `class`.
    * Value types (`struct`) can have significiant performance benefits (benchmarks?).
    * Swift uses copy on write - which means structs are only copied when they are mutated.

* Review common protocols
    * Protocol inheritance.
    * `extension`s can be used to add protocol conformance.
    * `Equatable` and `Hashable`

* Interoperability with Objective-C
    * Bridging header : Exposes Objective-C code to Swift.
    * What is the relationship between Swift and Objective-C libraries like `Foundation`?

* Error Handling

* Modules / Frameworks
    * Namespaces

* Versioning

* Package management
    * Swift Package Manager
    * Cocoapods

## Libraries

* Swift standard library
  * Strings
* GCD
* XCTest
* Serialization

## Tools

* Comments (doxygen? `CLANG_WARN_DOCUMENTATION_COMMENTS`)
* AppCode
* LLVM
* LLDB
* `swift` REPL