//
//  Container.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 10/5/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

//
// Container is a generic data structure protocol which allows you to add
// and get items, as well as get a count of the items in the container.
//
// Swift is a Protocol-Oriented Language. Rather than using OO inheritance, it is
// better to use protocols. Inheritance hierarcies can get messy.
//
// The way to use generics within protocols is to use associated types. An associated
// type is simple to understand - it is a generic type parameter for a protocol. That's it!
//
// Protocols with Associated Types (PATs) are trickier to understand and use than just using
// a typical protocol. You can't just define a variable of a Protocol with an Associated Type
// like you can with typical protocols. For example:
// This will not compile:
//
// var c: Container
//
// Error: Protocol 'Container' can only be used as a generic constraint because
//        it has Self or associated type requirements
//
// Why?
//
// Because the generic type parameter is not known. You must specify the type parameter
// using a ganeric constraint.

///
/// Associated types are generics for protocols.
///
/// Associated types allow you to specify a placeholder type that will be
/// provided by each protocol implementation. Associated types are only available
/// with protocols.
///
protocol Container {
    
    associatedtype Item

    /// Append a new element to the container.
    mutating func append(_ item : Item)
    
    /// The count of all elements in the container.
    var count: Int { get }
    
    /// Allows c[i] ordinal access into the container.
    subscript(i: Int) -> Item { get }
}

/// Subscripts can be generic and include generic type constraints.
///
/// Here, this subscript accepts a sequence of Ints, returning an array of items
/// at the given indices.
///
/// ```
/// let c = [];
/// ```

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

/// A protocol can appear as part of it's own requirements.
///
/// This protocol defines a suffix method which must
/// return an instance of a type conforming to Suffixable container,
/// having items the same type as the Container's item.
///
/// This shows that an associated type can refer to itself.

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size:Int) -> Suffix
}

/// Array naturally conforms to container as defined above.
///
/// You still must manually declare the type conforms to the protocol.
///
/// Simply implementing all the protocol requirements is not enough to
/// to *officially* conform to the protocol - you need to make it explicit.
extension Array: Container {
    typealias Item = Element
}
