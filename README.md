# Swift Fundamentals #

Every programming language has an idomatic style and set of library
features that are "core" to its understanding. To become truly
proficient in any language, you must understand it's idioms and core
libaries.

This repo will show you this "core" set of swift features. This
`README` describes at a very high level the highlights and main points
of swift. The source code is laid out in a way that will show a single
feature, pattern, or library by itself.

## Start here ##

* `Basics.playground` contains a brief overview of swift's main
  features. For example : classes, generics, optionals, lambdas, and
  functions.

* Run the tests (Cmd-U) to execute a suite of tests which show various
  lauguage and library features.

## Required reading ##

Just like every language has its idioms, it also has its bibles - the
sources of truth that all programmers agree are seminal. The following
sources are "must reads" for every swift programmer.

* [swift.org](http://swift.org) : Home of the swift open source
  project. Start here.

* [Chris Lattner's Homepage](http://www.nondot.org/sabre/): Chris
  started swift as well as the vast majority of the modern Apple
  toolchain, including LLVM and the compiler infrastructure.

* [The Swift Programming
  Language](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/)
  : The seminal book describing the swift language.

* [Using Swift with Cocoa and Objective-C (Swift 2.1)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html#//apple_ref/doc/uid/TP40014216)


## Swift, The Language ##

"It's designed to scale from "hello, world" to an entire operating
system" - The Swift Programming Language


* "Objective-C without the C"
  * Safe
    * Pointers are hidden by default.
    * Type safety (generics : Array<String> > NSArray).
    * Explicit type casting required.
    * Any type can be `optional`, even "primitives" like Int.
    * Conditionals must be boolean expressions.
    * Switch automatically `break`s.
    * Optionals : one true "empty" (sentinal?) value to rule them all (nil, NSNotFound, 0, etc..)
    * Object initialization : all properties must have a value or the object fails initialization.
    * Defer : better way to clean up resources.

  * Modern
    * No header files.
    * Functions are first class.
    * String interpolation.
    * Tuples allow for simple data structures and multiple return values.

* Strongly Typed (this will upset the dynamic language people)
  * Generics
  * Type inference
  * No need for non-mutable and mutable versions of the same classes.

* Interoprable with Objective-C. Swift was built to interoperate with
  Objective-C. Apple could not simply update the entire cocoa library,
  therefore swift bridges with Objective-C nicely.

* Based on ARC - still subject to retain cycles. Apple provides
  "capture lists" to allow developers to specify capture semantics.

* Objective-C and the underlying compiler infrastructure has been updated over 
  the years which has "paved the way" for swift.

## Tools ##

* [Jazzy](https://github.com/Realm/jazzy) : HTML Documentation generator for swift and objc. Outputs documentation files in HTML which mirror Apple's documentation look and feel.

* [VVDocumenter](https://github.com/onevcat/VVDocumenter-Xcode) : An Xcode plugin that will generate comment templates based off a function definition.

* [Alcataraz](http://alcatraz.io/) : Xcode package manager


-------------

## Next Steps ##

* Protocols
* Namespaces / packages
* Concurrency (channels?)
* Generics
* Extensions
* Structs


### Questions ###

* Modules: How to create / import a module? 
* Modules: What is an umbrella header?
* Modules: What is a module.modulemap file?


#### Objects ####

* How to hide local class vars from the class's public interface?
* What is protocol composition?

* Primitive types : lists and API. (All value types?)
    * Swift style guide (formatting tools like godoc?)

* How can we view playgrounds or write playgrounds that have rich comments / 
documentation in them?

* What are the Objc attributes for interoperating with swift (read the swift interop book)

#### Tools ####
