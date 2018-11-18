//
//  Stack.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 10/7/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

struct Stack<Element> {

    var items = [Element]()
        
    init(elements: Element...) {
        for e in elements {
            self.push(e)
        }
    }
    
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
    
    //
    // When implementing protocols with associated types, the implementor (Stack) must declare the
    // actual type
    // The `Item` type found on these protocol members should equal Stack's `Element` type.
    //
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
}

extension Stack: SuffixableContainer {
    
    //
    // Swift infers that SuffixableContainer's "Suffix" type is type Stack<Element>,
    // so this could be omitted. We keep it here to show what would be inferred.
    //
    typealias Suffix = Stack<Element>
    
    func suffix(_ size: Int) -> Stack<Element> {
        var result = Stack<Element>()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }
}

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

/// Another extension which will only be available to Stack<Int>()
///
/// This shows constraining a generic type down to a single type.
/// It's a very restrictive constraint.
extension Stack where Element == Int {
    
    var average: Double {
        var sum = 0.0
        for index in 0..<self.count {
            sum += Double(self[index])
        }
        return sum / Double(self.count)
    }
    
    var total: Int {
        return self.items.reduce(0, { (result, i) -> Int in
            result + i
        })
    }

}
