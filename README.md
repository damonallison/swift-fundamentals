# Swift Fundamentals

Every programming language has an idiomatic style and set of library features
that are "core" to its understanding. To become truly proficient in any
language, you must understand these idioms and core libraries.

This repo will show you this "core" set of swift features. This `README`
describes at a very high level the highlights and main points of swift. The
source code is laid out in a way that will show a single feature, pattern, or
library by itself.

## Start here

* `Basics.playground` contains a brief overview of swift's main features. For
  example : classes, generics, optionals, lambdas, and functions.

* Run the tests (Cmd-U) to execute a suite of tests which show various language
  and library features.

## Required reading

Just like every language has its idioms, it also has its bibles - the sources of
truth that all programmers agree are seminal. The following sources are "must
reads" for every swift programmer.


* [swift.org](http://swift.org) : Home of the swift open source project. Start here.

* [Chris Lattner's Homepage](http://www.nondot.org/sabre/): Chris started swift
  as well as the vast majority of the modern Apple toolchain, including LLVM and
  the compiler infrastructure.

* [The Swift Programming Language](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/) :
  The seminal book describing the swift language.

* [Using Swift with Cocoa and Objective-C (Swift 2.1)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/index.html#//apple_ref/doc/uid/TP40014216)


## Swift Overview

> "It's designed to scale from "hello, world" to an entire operating system"
> - The Swift Programming Language

### Safe

* Pointers are hidden by default.
* Conditionals must be boolean expressions.
* Switch automatically `break`s.

* Strongly Typed (this will upset the dynamic language people, but it's the right way to build a language)
* Explicit type casting required.
* Generics
* Type inference

* Optionals :
  * One true "empty" (sentinal?) value to rule them all (nil, NSNotFound, 0, etc..)
  * Any type can be `optional`, even "primitives" like Int.

* Object initialization : all properties must have a value or the object fails initialization.
    * Much better than Objective-C's `if (self = [super init])` initializer.
    * Also much safer and strict. Objective-C was more confusing, especially around when you could use `self`.

* Defer : better way to clean up resources.
* Error handling is clean, performant in that it doesn't unwind the stack.

### Modern

* No header files.
* Functions are first class.
* String interpolation.
* Tuples allow for simple data structures and multiple return values.
* ivars are removed. You cannot define or access a property's ivar directly. Much less error prone.

* var / let : no need for non-mutable and mutable versions of the same classes (e.g. NSString, NSMutableString)

### Evolution of Objective-C : "Swift is `Objective-C without the C`"

* Interoperable with Objective-C. Swift was built to interoperate with Objective-C. Apple could not simply update the entire cocoa library, therefore swift bridges with Objective-C nicely.
* Based on ARC - still subject to retain cycles. Apple provides "capture lists" to allow developers to specify capture semantics.
* Objective-C and the underlying compiler infrastructure has been updated over the years which has "paved the way" for swift.


### Dislikes

* Swift allows optional parens and semi-colons. It should force one or the other.
* There is no code-formatter (`go-fmt`).
  * No style consistency between projects.
  * Requires each team to have unproductive "style wars".

## Swift Language

### Access Control

* Safe by default. Swift's general rule on access control is: access control will be the most restrictive it can be.
* The swift compiler won't allow you to violate it's access control rules.
* Nothing is `public` unless specifically marked as such. Swift defaults all members to internal, requires you to opt into declaring things `public`.
* The only time a member can become **more** visible is in subclassing. A subclass can override a `private` function with an `internal` function, for example, as long as the superclass's function is accessible within the context where it is being overridden. The compiler must enforce these rules, so you won't be able to violate these rules.
* If your type is `private`, all members will be private by default.
* If your type is `public`, all members will be internal by default. Swift requires you specifically mark members as `public` to require the engineer to make things public - there is **nothing** public unless it's specifically marked as such.
* The access level of a tuple type is the most restrictive of it's members.
* The access level for a function is the most restrictive access level of it's parameter and return types. You must specify the access level explicitly if the function's calculated access level doesn't match the contextual default. (The compiler **requires** you to explicitly mark the function if it's not the default (private or internal).



## Tools

* [Jazzy](https://github.com/Realm/jazzy) : HTML Documentation generator for swift and objc. Outputs documentation files in HTML which mirror Apple's documentation look and feel.
* [VVDocumenter](https://github.com/onevcat/VVDocumenter-Xcode) : An Xcode plugin that will generate comment templates based off a function definition.
* [Alcataraz](http://alcatraz.io/) : Xcode package manager
