## iOS 9 / 2015 ##

* iOS 9
* Multitasking
* Search : exposing app data to the OS. Universal links bring the user directly to the right spot in the app.
* (Games) ReplayKit - record the screen - useful for customer debugging / error reporting?
* Safari VC

* Xcode7 :
* What markdown syntax is supported for QuickLook documentation (links, images, headers, etc).
* Crash Logs : automatically symbolicated / collected by the app store.
* Xcode server to run bots / tests on checkin.

* Testing
* Record UI actions. Write code to drive UI.
* Code Coverage : How?

* Swift
* Error handling
* Protocol extensions
* Testability - all methods exposed to tests - how?
* LLDB REPL
* Modules

* Objective-C
* Generics
* Nullability

* App Thinning
* Bitcode - upload LLVM code to Apple. Apple compiles for device during distribution.
* Slicing - only required assets are sent to device during distribution.
* On-Demand resources - lazy load content (game levels, etc)

* Free provisioning
* Can anyone install any project on their own device? No profile required?


# Questions #

* How to make a swift module / framework?

      import DamonKit

* What functions (and objects) are available at the global scope?

## Swift, The Language ##

* "Objective-C without the C"
  * Safe
    * Pointers are hidden by default.
    * Type safety (generics : Array<String> > NSArray).
    * Explicit type casting required.
    * Any type can be optional, even "primitives" like Int
    * Conditionals must be boolean expressions.
    * Switch automatically 'break's.
    * Optionals : one true "empty" (sentinal?) value to rule them all (nil, NSNotFound, 0, etc..)

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


## Swift, The Tools ##

9/9 - Swift 1.0.

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
