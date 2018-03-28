//
//  Generics.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/15/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//


// constraints
//   * type inherits from a specific base
//   * type conforms to a specific protocol

// where clauses
//   * list of requirements where each type parameter:
//        * inherits from a specific base or conforms to a specific protocol.

import XCTest

class GenericsTests: XCTestCase {


    func testGenericFunction() {

        func mySwap<T>(one: inout T, two: inout T) {
            let temp: T = one
            one = two
            two = temp
        }

        var i = 1, j = 2
        mySwap(one: &i, two: &j)
        XCTAssertEqual(2, i)
        XCTAssertEqual(1, j)
    }

    func testGenericType() {

        var s = Stack<Int>()
        s.push(100)
        s.push(200)
        XCTAssertEqual(200, s.pop())
        XCTAssertEqual(100, s.pop())
        XCTAssertNil(s.pop())

        // Because Int conforms to Hashable, we have access to functionality
        // in the extension below.
        s.push(1)
        XCTAssertEqual(1, s.topItem)
    }


    /// Generic type constraints allow you to specify that type parameters must inherit from a
    /// base class or implement one or more protocols.
    func testGenericTypeConstraints() {

        class GenericClass {

            static func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
                for (index, value) in array.enumerated() {
                    if value == valueToFind {
                        return index
                    }
                }
                return nil
            }

            // Here is an example of a generic where clause.
            //
            // Generic where clauses allow you to:
            //
            // * Specify a generic type parameter conforms to a certain protocol.
            // * Specify that types or associated types are the same.
            //
            // This generic where clause requires T and U to both be sequence types,
            // with their sequence element types being equal and implement Equatable.
            static func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, rhs: U) -> Bool where
                T.Iterator.Element: Equatable,
                T.Iterator.Element == U.Iterator.Element {
                    for lhsItem in lhs {
                        for rhsItem in rhs {
                            if lhsItem == rhsItem {
                                return true
                            }
                        }
                    }
                    return false
            }
        }

        XCTAssertEqual(1, GenericClass.findIndex(of: 100, in: [1, 100, 101]))
        XCTAssertTrue(GenericClass.anyCommonElements([1, 2, 3], rhs: [3, 4, 5]))
        XCTAssertFalse(GenericClass.anyCommonElements([1, 2, 3], rhs: [4, 5, 6]))
    }


    func testAssociatedTypes() {

        var mc = Stack<Int>()
        mc.append(100)
        mc.append(200)

        XCTAssertEqual(2, mc.count)
        XCTAssertEqual(200, mc[1])


    }

}

/// Associated types allow you to specify a placeholder type that will be
/// provided by each protocol implementation. Associated types are only available
/// with protocols.
///
/// You can constrain an associated type in the sa
protocol Container {
    associatedtype Item: Hashable

    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

/// A protocol can appear as part of it's own requirements.
/// Here, a protocol defines a suffix method which must
/// return an instance of a type conforming to Suffixable container,
/// having items the same type as the Container's item.
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size:Int) -> Suffix
}

struct Stack<Element: Hashable>: Container {
    var items = [Element]()


    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        if (items.count == 0) {
            return nil
        }
        return items.removeLast()
    }

    // MARK:- Container protocol conformance

    // NOTE: You don't need this. Swift can infer that "Item" is an Element based
    //       on type inference. (By looking at the append or subscript signatures)
    typealias Item = Element

    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

/// Note that when you extend a generic type, you don't provide a type list.
/// The type parameter list from the original type definition is available
/// within the body of the extension.
///
/// Notice that this extension includes a type constraint.
/// The functionality of the extension will only be available to instances
/// whose Element conforms to Hashable.
extension Stack where Element: Hashable  {
    var topItem: Element? {
        return self.items.isEmpty ? nil : self.items[self.items.count - 1]
    }
}

extension Stack: SuffixableContainer {

    // Swift infers that SuffixableContainer's "Suffix" type is type Stack<Element>,
    // so this could be omitted.
    typealias Suffix = Stack<Element>

    func suffix(_ size: Int) -> Stack<Element> {
        var result = Stack<Element>()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }

}
