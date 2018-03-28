//
//  ProtocolTests.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 3/28/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import XCTest

class ProtocolTests: XCTestCase {

    class Person: Named {
        var name: String

        // Readonly protocol properties can be implemented with let.
        // Notice they are declared in the protocol with `var`
        // Type properties can be declared as `static` or `class`.
        static let version = 1

        init(name: String) {
            self.name = name
        }

        /// When implementing an initializer from a protocol, it must
        /// be marked as `required`.
        ///
        /// This makes complete sense - any subclass must also
        /// conform to the protocol and implement the initializer.
        required convenience init(firstName: String, lastName: String) {
            self.init(name: "\(firstName) \(lastName)")
        }

        func appendSurname(surname: String) {
            if (surname.isEmpty) {
                return
            }
            self.name += " \(surname)"
        }

        static func ==(lhs: Person, rhs: Person) -> Bool {
            return lhs.name == rhs.name
        }

        var hashValue: Int {
            return name.hashValue
        }
        var textDescription: String {
            return "Person: \(self.name)"
        }

        /// The Named protocol has an extension which defines nameAndVersion.
        /// Here, we override the default implementation specified in the protocol.
        func nameAndVersion() -> String {
            return "Person with name \(self.name) version \(type(of: self).version)"
        }
    }

    func testProtocols() {
        let p = Person(name: "damon"), p2 = Person(name: "damon")
        XCTAssertEqual(p, p2)
        XCTAssertEqual(1, Person.version)
        p.appendSurname(surname: "jr")
        XCTAssertEqual("damon jr", p.name)

        let p3 = Person(name:"cole")


        /// A protocol is a full fledged type. It can be used
        /// anywhere a type is required, can be used as a generic
        /// type constraint, etc.
        func getNames<T: Named>(named: [T]) -> [String] {
            return named.map({$0.name})
        }

        let people = [p2, p3] // [Person]
        XCTAssertEqual(["damon", "cole"], getNames(named:people))

        // Test protocol extensions. Notice that "Named" is extended below to
        // include a nameAndVersion func.
        XCTAssertEqual("Person with name damon version 1", p2.nameAndVersion())
    }

    /// You can require a type to conform to multiple protocols by using
    /// protocol composition
    func testProtocolComposition() {

        /// Here, protocol composition requires that param implement both
        /// Named and Hashable.
        ///
        /// Note this is redundant. Named implements Hashable. But this is
        /// for illustration purposes only.
        func printHashAndName<T: Named & Hashable & TextRepresentable>(param: T) -> String {
            return "\(param.name): \(param.hashValue)"
        }
        let p = Person(firstName: "damon", lastName: "allison")

        XCTAssertTrue(printHashAndName(param: p).contains("damon"))
    }

    #if swift(>=4.1)
    func testConditionalConformance() {
        let a = [Person(name: "damon"), Person(name: "cole")]

        // Because Person conforms to TextRepresentable,
        // Array<Person> also conforms to TextRepresentable.
        XCTAssertEqual("Person: damon, Person: cole", a.textDescription)
    }
    #endif

    /// Optional protocol requirements allow you to define "optional" interface
    /// elements as you could in Objective-C. Optional protocol requirements are
    /// available so you can interoperate with Objective-C.
    func testOptionalProtocolRequirements() {

        class Counter: NSObject, CounterDataSource {
            private var count: Int = 0

            var currentCount: Int {
                return count
            }
            override init() {
                super.init()
            }

            @discardableResult
            func increment() -> Int {
                count += 1
                return count
            }

            /// NOTE: We do *not* implement fixedIncrement in this class!
            /// Set the increment step.
            /// @objc optional var fixedIncrement: Int { get }
        }

        let c = Counter() as CounterDataSource
        XCTAssertNotNil(c.increment?())
        XCTAssertEqual(1, c.currentCount)
        XCTAssertNil(c.fixedIncrement)
    }

}

/// This protocol can be implemented by any type - Enum, Structure, or Class.
///
/// This example shows protocol inheritance. Protocol inheritance allows you
/// to define a protocol which adds requirements in addition to existing
/// protocols.
///
/// To resrict the protocol to be implemented only by class types, add
/// `AnyObject` to the list of protocols this protocol derives from.
///
/// protocol Names: Equatable, AnyObject
///
/// AnyObject should be used for delegates, which should be a class type.
protocol Named: Hashable, TextRepresentable {

    /// Protocols can require initializers.
    ///
    /// When implementing the initializer, you must mark the initializer
    /// as required.
    init(firstName: String, lastName: String)

    /// Properties are *always* delcared as var.
    var name: String { get set }

    /// Readonly properties can be implemented using `var` or `let`,
    /// but they must be defined as `var` in the protocol.
    ///
    /// Always decorate type properties with `static`.
    /// When implementing the protocol, the implementation can declare
    /// them as `static` or `class`.
    static var version: Int { get }

    /// If a protocol can be implemented by value types (structs or enums)
    /// and can mutate state, define them as `mutating`.
    mutating func appendSurname(surname: String)
}

/// Protocols can be extended.
///
/// If the conforming type provides it's own implementation of the extension
/// functions, that implementation will be used rather than the default
/// specified here.
extension Named {
    func nameAndVersion() -> String {
        return "\(self.name) \(type(of: self).version)"
    }
}


/// Conditional conformance (Swift 4.1)
///
/// Conditional conformance allows a type to conform to a protocol under certain conditions,
/// like when the type of its generic parameter conforms to the protocol.

#if swift(>=4.1)

protocol TextRepresentable {
    var textDescription: String { get }
}

/// Array conditionally conforms to TextRepresentable.
///
/// Only when Element conforms to TextRepresentable will Array
/// conform to TextRepresentable.
extension Array: TextRepresentable where Element: TextRepresentable {
    var textDescription: String {
        return self.map({ $0.textDescription }).joined(separator: ", ")
    }
}

#endif

/// When dealing with Objective-C classes, you can define protocol members
/// as optional.
///
/// Note that when a protocol member is "optional", the return type is
/// always optional.
@objc protocol CounterDataSource {

    var currentCount: Int { get }

    @objc optional func increment() -> Int

    /// Set the increment step.
    @objc optional var fixedIncrement: Int { get }
}
