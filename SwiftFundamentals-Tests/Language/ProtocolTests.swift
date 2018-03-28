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
    }

    /// You can require a type to conform to multiple protocols by using
    /// protocol composition
    func testProtocolComposition() {

        /// Here, protocol composition requires that param implement both
        /// Named and Hashable.
        ///
        /// Note this is redundant. Named implements Hashable. But this is
        /// for illustration purposes only.
        func printHashAndName<T: Named & Hashable>(param: T) -> String {
            return "\(param.name): \(param.hashValue)"
        }
        let p = Person(firstName: "damon", lastName: "allison")

        XCTAssertTrue(printHashAndName(param: p).contains("damon"))
    }

    #if swift(>=4.1)
    func testConditionalConformance() {

    }
    #endif

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
protocol Named: Hashable {

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


/// Conditional conformance (Swift 4.1)
///
/// Conditional conformance allows a type to conform to a protocol under certain conditions,
/// like when the type of its generic parameter conforms to the protocol.

#if swift(>=4.1)
protocol TextRepresentable {
    var textDescription: String { get }
}

extension Array: TextRepresentable where Element: TextRepresentable {
    var textDescription: String {
        return self.map({ $0.textDescription }).joined(separator: ", ")
    }
}
#endif

/// When dealing with Objective-C classes, you can define protocol members
/// as optional.
@objc protocol CounterDataSource {
    @objc optional func increment() -> Int
}
