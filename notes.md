# Swift Notes

## Access Control

* `open`
  * Open grants anyone inside or outside the module the ability to subclass the
    `open` class.
  * Marking a class as `open` says:

    > I've considered the impact of code from other modules subclassing this class.

  * Applies to classes and class members only.
  * Allows classes to be subclassed from any module.

* `public`
  * The public API for the framework.
  * Swift requires you to mark public API as `public` to force you to think
    about what you are doing.

* `@testable` allows a unit test target to access any internal entity within the
  module being imported.

* You can give a property setter a lower access level than it's getter by giving
  `set` a custom level. `private(set)` or `fileprivate(set)` for example.

* You can specify the access level of the getter and setter for a property:

```
	public private(set) var numberOfEdits = 0
```

## Attributes (declaration modifiers)

* `dynamic` : use dynamic dispatch for this member. Implies `objc`.
* `objc` : make the declaration available to Objective-C.
