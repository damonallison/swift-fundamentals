# Swift TODO

* UITextField custom overlay (`cut`, `copy`, `paste`)
* Library for automatically verifying all `@IBOutlet`s are non-nil.
* Accessability 

* Programmatically manipulating constraints (`heightAnchor`, `widthAnchor`).
* Multiple asset catalogs or single? Why? Memory?

* Install `fish` shell.
* What does the system environment look like?
    * Where are directories stored?
* How to analyze swift for dead code?
* Why can't lazy properties have observers?
* Person.swift - verify access modifier explanation.
* Point.swift - verify access modifier explanation.
* Why does a new Swift file include `import Foundation`?
* Does `XCTest` run tests serially or in parallel?
* Memory Management : What is `Thread Sanitizer`?
> Use Thread Sanitizer to help detect conflicting access across threads.
* How does `@testable` work?

* In Swift 4.1, what protocols are synthesized by default?
    > Structures that have only stored properties that conform to `Equatable`.
    > Enums that have only associated types that conform to `Equatable`.
    > Enums that have no associated type.


## Language

* Type system
    * What is `Any` and `AnyObject`?
    * `Self` type keyword.

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

* Objective-C / Swift Interoperability
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

* Xcode
    * What is the difference between `xcodeproj` and `xcworkspace`?

* Comments (doxygen? `CLANG_WARN_DOCUMENTATION_COMMENTS`)
* AppCode
* LLVM
* LLDB
* `swift` REPL

---


## [Start Developing iOS Apps (Swift)](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214)

* `@IBOutlet weak var fieldName: UITextField!`

`weak` is used because the VC maintains a strong ref to it's main UIView (content view). The main UIView maintains a strong reference to it's child views. Therefore, `weak` avoids creating a reference cycle.

When `viewDidLoad` is called, all `@IBOutlet`s will be wired up.

* `UIView` vs. `UIControl` : `UIControl` allows the view to be manipulated in some way.

* To give views control like capabilities (ability to respond to user events), add `UIGestureRecognizer`s.

* Dragging images to the simulator will add them to the Simulator's "camera roll".

* When creating a `UIView` programmatically, disable autoresizing constraints. 

```
        let button = UIButton()
        button.translatesAutoResizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
```

* `Selector`s have largely been replaced by blocks.

* `@IBDesignable` lets IB draw your control.

* [App Programming Guide for iOS](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007072)

* [View Programming Guide](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009503)

* [View Controller Programming Guide](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/index.html#//apple_ref/doc/uid/TP40007457)

* [Collection View Programming Guide](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012334)

* [Table View Programming Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/AboutTableViewsiPhone/AboutTableViewsiPhone.html#//apple_ref/doc/uid/TP40007451)

* [File System Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010672)

* [Local and Remote Notification Programming Guide](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/index.html#//apple_ref/doc/uid/TP40008194)

* [Apple File System Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/APFS_Guide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40016999)

* [Networking Overview](https://developer.apple.com/library/content/documentation/NetworkingInternetWeb/Conceptual/NetworkingOverview/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010220)

* [Bundle Programming Guide](https://developer.apple.com/library/content/documentation/CoreFoundation/Conceptual/CFBundles/Introduction/Introduction.html#//apple_ref/doc/uid/10000123i)

* [Resource Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/LoadingResources/Introduction/Introduction.html#//apple_ref/doc/uid/10000051i)

* [Auto Layout Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853)

* [Threading Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Multithreading/Introduction/Introduction.html#//apple_ref/doc/uid/10000057i)

* [String Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/introStrings.html#//apple_ref/doc/uid/10000035i)

* [Exception Programming Topics](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Exceptions/Exceptions.html#//apple_ref/doc/uid/10000012i)

* [Notification Programming Topics](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Notifications/Introduction/introNotifications.html#//apple_ref/doc/uid/10000043i)

## Reference

* [Entitlement Key Reference](https://developer.apple.com/library/content/documentation/Miscellaneous/Reference/EntitlementKeyReference/Chapters/AboutEntitlements.html#//apple_ref/doc/uid/TP40011195)

* [Information Property List Key Reference](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009247)

* [iOS Device Compatibility Reference](https://developer.apple.com/library/content/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013599)
