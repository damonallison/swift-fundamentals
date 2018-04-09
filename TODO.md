# Swift TODO

* Responding to keyboard events.
* How to animate swapping two views using only constraint changes?

* iOS application startup sequence.
    * From `UIApplicationMain`, to loading the main storyboard, to creating the `AppDelegate`, run loop, `UIApplication`, and `UIWindow`. 
    * What is the detailed sequence of events iOS does when initializing the app?

* `UILayer` and their relationship to `UIView`.
* UI responder chain -> subview -> parent view -> VC -> UIApplication(?)

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

* Serialization: `Codable` / `NSCodable` / `NSSecureCodable`
    * Does `Codable` replace both?
    * How to serialize / deserialize to / from JSON?

* Swift standard library
  * Strings

* Multithreading
    * GCD
    * Run loops

* XCTest
* Alamofire

* Research `os.log`. Compare to 3rd party logging offerings. Can log to a cloud infrastructure?

## Tools

* Xcode
	* What is the difference between `xcodeproj` and `xcworkspace`?
	* In the `Identity Inspector` - what are all the values used for?

* Comments (doxygen? `CLANG_WARN_DOCUMENTATION_COMMENTS`)
* AppCode
* LLVM
* LLDB
* `swift` REPL


---

# Foundational

## [Start Developing iOS Apps (Swift)](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214)

### IBOutlet

Define `@IBOutlet`s as `weak`. Why? The VC maintains a strong ref to it's main UIView (content view). The main UIView maintains a strong reference to it's child views. Therefore, `weak` avoids creating an unnecessary reference between the VC and the view.

When `viewDidLoad` is called, all `@IBOutlet`s and `@IBAction`s will be wired up.

`@IBOutlet`s must be optional since they are not created during initialization.

#### Example

`@IBOutlet weak var fieldName: UITextField!`

### UIView vs. UIControl

`UIView` vs. `UIControl` : `UIControl` allows the view to be manipulated in some way.

To give UIViews control like capabilities (ability to respond to user events), add `UIGestureRecognizer`s. For example, to allow a UIImage to respond to touch events, add a `UITapGestureRecognizer` to the UIImage.

When creating a `UIView` programmatically, disable autoresizing constraints. 

```
        let button = UIButton()
        button.translatesAutoResizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
```
### Interface Builder Integration

* `@IBDesignable` lets IB draw your control.
* `@IBInspectable` adds your properties to IB's Attributes Inspector.


## [App Programming Guide for iOS](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007072)

The App Programming Guide focuses on the application lifecycle and inter-app communication. It discusses how iOS and your app communicate and how to be a good citizen in the iOS environment.

Before you ship an app, read this document and apply it to your app.

* Are you handling state transtitions correctly?
* Are you missing any features / opportunities for communicating with other apps or allowing others to communicate with you?
* Are there any background modes or lifecycle events you want to subscribe to?

### Info.plist

The `General`, `Capabilities` and `Info` tabs shown for an Xcode project file write to `Info.plist`. 

#### Important Info.plist keys

* `UIRequiredDeviceCapabilities` - a list of hardware / features the device must support for the app to be installed.
* `UIRequiresPersistentWifi` - prevents iOS for shutting down wifi while the app is running. Recommended if your app talks to network (all apps?). 

There are also feature specific keys that must be set to use the feature. For example, asking for sensitive data requires usage descriptions.

* `NSPhotoLibraryUsageDescription` - required when your app accesses the photo library.

#### UIResponder

* `UIControl` objects package touch events into action messages and deliver them to a target.
* `UIView` objects do *not* use the target-action method and handle the events in the `UIResponder` chain.



# UIKit

## [View Programming Guide](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009503)

### Views

* Views provide user interface and handle user interactions.
* Each `UIView` is backed with a `CALayer` object. 
    * Always prefer to use operations on `UIView` rather than `CALayer`. 
    * Only use `CALayer` when necessary.

* Views have `z-order`. Those added later in a subview array appear frontmost.

#### Drawing

> Golden Rule: When using auto layout, modify view sizes by adjusting constraints - not modifying frame / bounds / center.

* Only when you change the content do you need to re-render the view by calling `setNeedsDisplay`.
* Call `setNeedsLayout` if you want to reapply constraints. Override `layoutSubviews` if you want to control the layout process.

* Changing the view's geometry does not cause a redraw. Most `contentMode` values will stretch the existing `UIView` bitmap.
* For drawing custom `UIView`s, override `drawRect:`.


##### contentMode

* `contentMode` determines how the view recycles itself in response to changes in the view's geometry.
* Use `UIViewContentModeRedraw` when you want your custom views to redraw themselves during scaling and resizing operations.
    * Only use this for custom views.

##### Animations

* Use `UIView` to animate view changes when possible. 

```
frame
bounds
center
transform
alpha
backgroundColor
contentStretch
```

* What are top / bottom layout guides?
    * "Laying out content to these guides ensures your content is always visible"
    * The position of the top layout guide factors in the height of the status bar / nav bar.
    * The position of the bottom layout guide factors in the height of a tab bar / toolbar.

## [View Controller Programming Guide](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/index.html#//apple_ref/doc/uid/TP40007457)

* [Collection View Programming Guide](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012334)

* [Table View Programming Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/AboutTableViewsiPhone/AboutTableViewsiPhone.html#//apple_ref/doc/uid/TP40007451)

* [Local and Remote Notification Programming Guide](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/index.html#//apple_ref/doc/uid/TP40008194)

# Xcode

* [Auto Layout Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853)


# Internal

* [Apple File System Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/APFS_Guide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40016999)

* [File System Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010672)

* [Networking Overview](https://developer.apple.com/library/content/documentation/NetworkingInternetWeb/Conceptual/NetworkingOverview/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010220)
* [Bundle Programming Guide](https://developer.apple.com/library/content/documentation/CoreFoundation/Conceptual/CFBundles/Introduction/Introduction.html#//apple_ref/doc/uid/10000123i)

* [Resource Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/LoadingResources/Introduction/Introduction.html#//apple_ref/doc/uid/10000051i)


* [Threading Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Multithreading/Introduction/Introduction.html#//apple_ref/doc/uid/10000057i)

* [String Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/introStrings.html#//apple_ref/doc/uid/10000035i)

* [Exception Programming Topics](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Exceptions/Exceptions.html#//apple_ref/doc/uid/10000012i)

* [Notification Programming Topics](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Notifications/Introduction/introNotifications.html#//apple_ref/doc/uid/10000043i)

## Reference

* [Entitlement Key Reference](https://developer.apple.com/library/content/documentation/Miscellaneous/Reference/EntitlementKeyReference/Chapters/AboutEntitlements.html#//apple_ref/doc/uid/TP40011195)

* [Information Property List Key Reference](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009247)

* [iOS Device Compatibility Reference](https://developer.apple.com/library/content/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013599)
