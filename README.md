# Questions #

* How to make a swift module / framework?

      import DamonKit

* What functions (and objects) are available at the global scope?

* iOS8 : Photos Framework.
* Apple Versioning (Xcode 6.1)

# Introduction to Swift #

On June 2nd, 2014, Apple's World Wide Developer Conference ([WWDC][wwdc]), Apple shocked it's developer community by introducing a new programming language called Swift.


## Swift, The Platform ##

* Apple's platform control - removing all 3rd party dependencies:
  * Java / Flash
  * No python / ruby

* Environment, history of Objective-C.
* Messy / risky parts of Objective-C (when compared to VM languages)
* Calls for Objective-C's end.
* Comparisons to Microsoft's C++/VB -> .NET transition.
* Apple preparing the way by modernizing Objective-C with ARC (others?)


### Moderizing Objective-C ###

Apple claims they "laid the foundation for swift" by modernizing Objective-C with ARC, blocks, modules, and standardizing Foundation and Cocoa APIs for uniformity, allowing Swift to play nice with Cocoa conventions.

We don't know if the improvements to Objective-C were implemented because they were simply good ideas or if they were intentionally meant to pave the way for Swift. Whatever the motive, the end result is the underlying "modernization" of Objective-C provides the foundation for Swift to cleanly co-exist with Objective-C and interoperate with libraries written in Objective-C as far back as Objective-C's introduction in 1983.

* Purely Apple - controlled by Apple.
* Interoperates with Objective-C - they don’t need to rebuild all Cocoa / Foundation libraries.
* Removes a lot of objective-c legacy rough edges.


## Swift, The Language ##

* "Objective-C without the C"
  * Safe
    * Pointers are hidden by default.
    * Type safety (generics : Array<String> > NSArray).
    * Explicit type casting required.
    * Any type can be optional, even Int. Not objects, like Objective-C.
    * Conditionals must be boolean expressions.
    * No exception handling.
    * Switch automatically 'break's.
    * Optionals : one true "empty" (sentinal?) value to rule them all (nil, NSNotFound, etc..)

  * Modern
    * No header files.
    * Functions are first class.
    * String interpolation.

* Strongly Typed (this will upset the dynamic language people)
  * Generics
  * Type inference
  * No need for non-mutable and mutable versions of the same classes.

* Interoprable with Objective-C.
* Based on ARC - still subject to retain cycles. Apple provides "capture lists" to allow developers to specify capture semantics.

## Swift, The Standard Library ##

## Swift, The Tools ##

* Playgrounds / REPL (Lattner's passion)
  * Make programming more immediately accessible, approachable, and fun.
  * Interactive documentation.



9/9 - Swift 1.0.

[wwdc]: https://developer.apple.com/wwdc/ "Apple - WWDC"
[lattner]: http://www.nondot.org/sabre/ "Chris Lattner's Homepage"

Swift is indeed a new programming language, however many of the "new features" have existed for years in other programming languages. Chris Lattner, swift's

## Getting Started ##

Open `swift-fundamentals-workspace.xcworkspace` to get started. This workspace
has two top level elements:

1. Playground. This is simply a scratchpad for you to try new ideas as you're
   reading over the swift-fundamentals source.

2. `swift-fundamentals` - project and target for all the fundamentals source
   code.

`swift-fundamentals` is a Mac command line target. Just run it.


-------------

# Swift Notes #


## Likes ##

Cleaning up C's mess.
    * Type inference.

* String interpolation, comparison.

* No header files
* Tuple members can be given names - simple way to create a lightweight data structure.
* Strings are value types.
* Strongly typed collections (array, dictionary)
* Generics

## Dislikes ##

* Doesn’t take a stand (semicolons allowed, not required, if () allowed, not required).
  At least {} around blocks are required.

* typealias
* Default indenting for switch, will/didLet, and other multi-nested control structures.

## Undecided ##

* Specifying a “second name” for a method parameter.



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

* WWDC : Integrating swift with objc
* WWDC : Swift interoperability in depth


* * * *


### Environment ###

* Will swift be open sourced? If sao, would you write server software in it vs. say, go?


### Objects ###

* How to hide local class vars from the class's public interface?
* What is protocol composition?
