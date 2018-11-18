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
        // in the extension below which defines "topItem". This shows
        s.push(1)
        XCTAssertEqual(1, s.topItem)
    }


    /// Generic type constraints allow you to specify that type parameters must inherit from a
    /// base class or implement one or more protocols.
    func testGenericTypeConstraints() {

        class GenericClass {

            /// Here is an example of a type constraint. T is constrained to Equatable, Hashable, and Comparable.
            ///
            /// Note this is a contrived example on two fronts:
            ///
            /// 1. Comparable conforms to Hashable. Hashable conforms to Equatable. So <T: Comparable> is all that's
            ///    needed if you wanted T to conform to all protocols.
            ///
            /// 2. The only element we use on T is Equatable's `==` function. Therefore, we only need to specify
            ///    <T: Equatable> for this function to be usable.
            ///
            /// The more constrained a parameter is, the more functionality we have available to use on the type,
            /// but the less "generic" the parameter is.
            static func findIndex<T: Equatable & Hashable & Comparable>(of valueToFind: T, in array: [T]) -> Int? {
                for (index, value) in array.enumerated() {
                    if value == valueToFind {
                        return index
                    }
                }
                return nil
            }

            // Here is a more comprehensive example of generic type constraints.
            //
            // Generic where clauses allow you to:
            //
            // * Specify a generic type parameter or the type's associated types conform to a protocol.
            // * Specify that types or associated types are the same.
            //
            // This generic where clause requires T and U to both be sequence types,
            // with their sequence element types being equal and implement Equatable.
            //
            // There are a few constraints defined here:
            //
            // 1. T is a Container.
            // 2. U is a Container.
            // 3. Both T and U's Iterator.Element associated types must be equal.
            // 5 T and U's associated type Item must conform to Equatable.
            //
            static func allItemsMatch<T: Container, U: Container>(_ lhs: T, rhs: U) -> Bool
                where T.Item: Equatable, T.Item == U.Item {
                if lhs.count != rhs.count {
                    return false
                }
                for i in 0..<lhs.count {
                    if lhs[i] != rhs[i] {
                        return false
                    }
                }
                return true
            }
        }

        XCTAssertEqual(1, GenericClass.findIndex(of: 100, in: [1, 100, 101]))

        // In this case, we have two different Sequence types (Array<Int>, Stack<Int>).
        // The generic function will accept both types since both conform to the correct protocol.
        var s = Stack<Int>()
        var a = [Int]()
        a.append(1)
        s.append(1)
        XCTAssertTrue(GenericClass.allItemsMatch(s, rhs: a))
    }


    func testAssociatedTypes() {

        // Here, stack conforms to both the Container and SuffixableContainer.
        // The associated type in both protocol implementations (See the Stack Container / SuffixableContainer extensions below)
        // is resloved to Int and Stack<Int> respectively by Swift's type inference.

        var s = Stack<Int>()
        s.append(100)
        s.append(200)

        // Show the ccontainer protocol
        XCTAssertEqual(2, s.count)
        XCTAssertEqual(200, s[1])

        #if swift(>=4.1)
        // Show the suffixable container protocol.
        XCTAssertEqual(1, s.suffix(1).count)
        XCTAssertEqual(200, s.suffix(1)[0])

        // Show the Container extension.
        XCTAssertEqual([100], s[[0]])
        #endif
        
    }
}

///
/// Associated types are generics for protocols.
///
/// Associated types allow you to specify a placeholder type that will be
/// provided by each protocol implementation. Associated types are only available
/// with protocols.
///
/// You can constrain an associated type in the same fashion as generic type constraints.
/// Here, we constrain `Item` to Hashable.
///
protocol Container {

    associatedtype Item

    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }

    #if swift(>=4.1)
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    #else
    associatedtype Iterator: IteratorProtocol
    #endif
    
    func makeIterator() -> Iterator
}

/// Subscripts can be generic and include generic type constraints.
///
/// Here, this subscript accepts a sequence of Ints, returning an array of items
/// at the given indices.

#if swift(>=4.1)
extension Container {

    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
        var result = [Item]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
    
}
#endif


/// A protocol can appear as part of it's own requirements.
///
/// This protocol defines a suffix method which must
/// return an instance of a type conforming to Suffixable container,
/// having items the same type as the Container's item.
///
/// This shows that an associated type can refer to itself.

#if swift(>=4.1)
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size:Int) -> Suffix
}
#endif


struct Stack<Element: Hashable> {
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
}

extension Stack: Container {

    // The `Item` type found on these protocol members should equal Stack's `Element` type.
    typealias Item = Element

    mutating func append(_ item: Item) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Item {
        return items[i]
    }
    func makeIterator() -> IndexingIterator<[Item]> {
        return items.makeIterator()
    }
}

#if swift(>=4.1)
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
#endif

/// Note that when you extend a generic type, you don't provide a type list.
/// The type parameter list from the original type definition is available
/// within the body of the extension.
///
/// Notice that this extension includes a type constraint.
/// The functionality of the extension will only be available to instances
/// whose Element conforms to Hashable.
///
/// This is a contrived example. There is no reason why we need to constrain
/// element to Hashable in this extension - we don't use Element.hashValue()
/// anywhere.
///
/// This is called conditional conformance. This extension is only available
/// when Element is Hashable.
extension Stack where Element: Hashable  {
    var topItem: Element? {
        return self.items.isEmpty ? nil : self.items[self.items.count - 1]
    }
}

/// Another extension which will only be available to Stack<Double>()
///
/// This shows constraining a generic type down to a single type.
/// It's a very restrictive constraint.

#if swift(>=4.1)
extension Stack where Element == Double {
    // Add interface here.
}
#endif

/// Array naturally conforms to container as defined above.
///
/// You still must manually declare the type conforms to the protocol.
///
/// Simply implementing all the protocol requirements is not enough to
/// to officially conform to the protocol.
extension Array: Container {}
