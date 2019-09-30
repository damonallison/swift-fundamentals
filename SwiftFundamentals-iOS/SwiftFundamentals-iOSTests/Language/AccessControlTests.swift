//
//  AccessControlTests.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 3/30/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import XCTest

/// ## Access Control
///
///
/// ### Goals
///
/// * Safe by design.
///     * `public` must be explicitly marked to prevent accidental visibility. You must explicitly opt into `public`.
///     * Access levels do not `leak`.
///     * You can’t expose member of a type with a more restrictive access level than the type in which it’s
///     * e.g., An `internal` class can’t expose a `fileprivate` member.
///     * Subclasses cannot have a broader access level than it's parent.
/// * Protocol inheritance cannot elevate the base protocol’s access level.
/// * e.g., a `public` protocol cannot extend an `internal` protocol.
///
///
///
///
/// ### Access Control Levels
///
/// * `open`
///     * Visible to all code in the module and other modules that import the module.
///     * Only applies to classes and class members.
///     * Open classes are subclassable by entities outside the module.
///     * Open class members are overridable outside the module.
///
///     > Marking a class as `open` explicitly indicates that you’ve considered the impact of code
///       from other modules using that class as a superclass and that you’ve designed your class’s code accordingly.
///
/// * `public`
///     * Visible to any module.
///     * Not subclassable by entities outside the module.
///
/// * `internal`
///     * Visible within the module.
///
/// * `file private`
///     * Visible within the source file.
///
/// * `private`
///     * Visible within the entity and extensions to that entity within the same source file.
///
///
///
///
/// ### Access Control Rules
///
/// * Access control is based on modules and source files.
/// * Each build target (app bundle or framework) is a separate swift `module`.
/// * Multiple types can be defined per source file.
///
/// Access levels in Swift follow an overall guiding principle:
///
/// > No entity can be defined in terms of another entity that
/// > has a lower (more restrictive) access level.
///
/// * Swift will ensure you can’t expose a private type via a public variable, or return a private type from a public function.
///
/// * For typical apps, leaving types as `internal` is sufficient.
/// * You are still encouraged to use `fileprivate` and `private` to encapsulate implementation details.
/// 
/// * A unit test target can access any internal entity by:
///     * `@testable import MyApp`
///     * Compile the test module with testing enabled. Test targets should already be setup with testing enabled.
/// 
///
/// ### Default Type Access Levels
///
/// The type's access level becomes the default access level for all members of a type.
///
/// For example, if you define a `fileprivate class` class, the default access
/// level for all members of that type becomes `fileprivate`.
///
/// ```
/// fileprivate class Person {
///     var firstName: String        // defaults to `fileprivate`
///     private var lastName: String // allowed - private is more restrictive
/// }
/// ```
///
/// `public` is special.  Members of a `public`  type are `internal` by default.
///
///
/// * Functions and tuples will have a calculated access level based on the types contained in the entity.
///   If the calculated access level for the tuple / function does not match the calculated value,
///   you must explicitly declare the entity’s access level
///
///
/// ```
/// // This will not compile.
/// //
/// // The default access level for `aFunc` is
/// // `internal`, however it's calculated access level is
/// // `private`.
///
/// func aFunc() -> (InternalClass, PrivateClass)
/// 
/// // You must delcare `aFunc` as `private`
/// private func aFunc() -> (InternalClass, PrivateClass)
/// ```
///
///
///
/// ### Subclassing
///
/// A subclass *can* call a superclass member that has a lower access level - as long as the call
//  is within an allowed context (i.e., within the same source file for a `fileprivate` member).
///
/// ```
/// public class A {
///     fileprivate func someMethod() {}
/// }
///
/// internal class B : A {
///     // someMethod() can be made more accessible from a subclass
///     // The call to `super.someMethod()` is OK since we are
///     // within an allowed context (fileprivate)
///     override internal func someMethod() {
///         super.someMethod()
///     }
/// }
/// ```
///
/// ### Properties
///
/// * A setter can have a lower access level than the getter.
///
/// ```
/// struct TrackedString {
///     [file]private(set) var numberOfEdits = 0
///     var value: String = "" {
///         didSet {
///             numberOfEdits += 1
///         }
///     }
/// }
/// ```
///
/// ### Functions
///
/// * The access level of a function is the most restrictive of it's parameter types and return type.
///
/// ### Protocols
///
/// * All members of a protocol are the same access type as the protocol itself.
/// * If the protocol is `public`, all members must be explicitly marked `public`.
/// * For each class that implements a protocol, each member implementation must at least have the same access level as the protocol itself.
///
/// ```
/// protocol Calculatable {
///     calculate() -> Int
/// }
///
/// // Both `Calculator` and `calculate` must be internal since `Calculatable` is internal.
/// class Calculator : Calculatable {
///     func calculate() -> Int { }
/// }
/// ```
///
/// ### Extensions
///
/// * By default, extensions inherit the access level of the extended class.
/// * You can mark an extension with a lower access level to give a new default to members within the extension.
///
/// * Important: Extensions that are in the *same file* as the class, enum, or struct being extended
///   behave as if the code in the extension had been written as part of the original type's declaration.
///
///   Therefore, extensions in the same file as the original type can:
///
///   * Access all private members in the original type or another extension
///     in the same file.
///
///   * Define new private members that can be used from the original type or
///     another extension in the same file.
///
///
/// In this example, we show an extension which lowers the default access level
/// from `fileprivate` to `private`.
///
///  By default, the extension would have inherited the `fileprivate` access
///  level from the `MyClass` type declaration.
///
///
/// ```
/// fileprivate class MyClass {
/// }
///
/// // `private` sets the default access level of all members
/// private extension MyClass {
/// // implicitly private
/// func extend() -> (Int, Int)
/// }
/// ```
///
public class AccessControlTests: XCTestCase {

    class Person: Descriptive {

        private class Id {
            var id = 0
        }

        /// Properties can have different access control for the getter and setter.
        ///
        /// The "get" will have the default access control level specified on the property.
        /// The "set" can have a *lower* access level by specifying it with "accesslevel(set)".
        ///
        /// This works for both stored and computed properties.
        fileprivate private(set) var middleName: String = "Unknowne"
        fileprivate private(set) var lastName: String {
            get {
                return "lastName"
            }
            set {
                print ("\(newValue)")
            }
        }

        /// This method *must* be private since it has a private parameter and return value.
        ///
        /// Swift access control ensures types cannot "leak" types, making them more
        /// accessable by exposing them via a function.
        private func getId(id: Id) -> Id {
            return id
        }

        let name: String
        init(name: String) {
            self.name = name
        }
        func describe() -> String {
            return "Person: \(self.name)"
        }
    }

    /// Class cannot be declared as public because it's superclass is internal.
    /* public */ class Manager: Person {

    }

    func testMe() {

        let p = Person(name: "damon")
        XCTAssertEqual("Person: damon", p.describe())

    }
}

/// The access level for all protocol members will be the access level of the protocol itself.
/// In this example, describe() is fileprivate.
///
/// You can't set a protocol requirement (member) to a different access level
/// than the protocol itself. This ensures that all of the protocol's requirements
/// are visible to any type that adopts the protocol.
///
/// This protocol can obviously only be implemented (and used) by classes in this file.
fileprivate protocol Descriptive {
    /* fileprivate */ func describe() -> String
}
