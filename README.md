# Swift Fundamentals #

Code examples that describe the fundamentals of the swift programming language.

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

## Overall Strategy ##

* Purely Apple - controlled by Apple.
* Interoperates with Objective-C - they don’t need to rebuild all Cocoa / Foundation libraries.
* Removes a lot of objective-c legacy rough edges.


Swift standard library
Using Swift with Cocoa and Objective-C


## Likes ##

* Type safety / type inference. Explicit casting required.
* Any type can be optional, even Int. Not objects, like Objective-C.
* String interpolation
* No header files
* Tuple members can be given names - simple way to create a lightweight data structure.
* Strings are value types.
* Strongly typed collections (array, dictionary)
* Generics

## Dislikes ##

* Doesn’t take a stand (semicolons allowed, not required, if () allowed, not required).
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


## Questions ##

### Objects ###

* How to hide local class vars from the class's public interface?
* What is protocol composition?

### TODO ###

* The Swift Programming Language - Language Reference
    https://developer.apple.com/library/prerelease/mac/documentation/Swift/Conceptual/Swift_Programming_Language/
