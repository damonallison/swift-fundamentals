# Swift Fundamentals #

Every programming language has an idomatic style and set of library features
that are "core" to its understanding. To become truly proficient in any language,
you must understand those idioms and features.

This repo will show you the "core" set of swift features. This `README` describes
at a very high level the highlights of the core features. The source code is laid
out in a way that will show a single feature, pattern, or library by itself.


## Start here ##

* Run `Basics.playground` to run thru a few quick examples.
* Run the tests (Cmd-U) to execute a suite of tests which show various lauguage
  features.

## Required reading ##

* [swift.org](http://swift.org) : Home of the swift open source project. Start here.
* [Chris Lattner's Homepage](http://www.nondot.org/sabre/): Chris started swift as well as the vast majority of the modern Apple toolchain, including LLVM and the compiler infrastructure.

* [The Swift Programming Language](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/) : The seminal book describing the swift language.

## Swift, The Language ##

"It's designed to scale from "hello, world" to an entire operating system" - The Swift Programming Language


Safe, Modern,
* "Objective-C without the C"
  * Safe
    * Pointers are hidden by default.
    * Type safety (generics : Array<String> > NSArray).
    * Explicit type casting required.
    * Any type can be optional, even "primitives" like Int.
    * Conditionals must be boolean expressions.
    * Switch automatically 'break's.
    * Optionals : one true "empty" (sentinal?) value to rule them all (nil, NSNotFound, 0, etc..)

  * Modern
    * No header files.
    * Functions are first class.
    * String interpolation.
    * Tuples allow for simple data structures and multiple return values.

* Strongly Typed (this will upset the dynamic language people)
  * Generics
  * Type inference
  * No need for non-mutable and mutable versions of the same classes.

* Interoprable with Objective-C. Swift was built to interoperate with Objective-C. Apple could not simply update the entire cocoa library, therefore swift bridges with Objective-C nicely.

* Based on ARC - still subject to retain cycles. Apple provides "capture lists" to allow developers to specify capture semantics.


## Swift, The Tools ##

"Swift is indeed a new programming language, however many of the "new features" have existed for years in other programming languages." - Chris Lattner

-------------

## Next Steps ##

* Protocols
* Namespaces / packages
* Concurrency (channels?)
* Generics
* Extensions
* Structs

## Additional Resources ##

Using Swift with Cocoa and Objective-C
https://developer.apple.com/library/prerelease/ios/documentation/swift/conceptual/buildingcocoaapps/index.html


### Objects ###

* How to hide local class vars from the class's public interface?
* What is protocol composition?
