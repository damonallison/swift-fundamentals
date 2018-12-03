//
//  Point.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 2/8/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

/// Structures are value types. In Swift, structures are very similar to classes.
////
/// Structures (and classes) support:
///
/// * Properties
/// * Methods
/// * Initializers
/// * Subscripts
/// * Extensions
/// * Protocol conformance.
///
/// Structures do **not** support:
///
/// * Inheritance
/// * Type casting
/// * Deinitializers (since structs are not put on the heap).
/// * Reference counting. Only one reference per struct.
///
///
/// When to use a struct vs. class?
///
/// * Structures should be relatively small and used only for
///   small, value type data structures. Classes are the primary
///   data structure in swift.
///
/// * All values in the structure should themselves be value types.
///
/// * Don't put reference types into a structure - use a class.
///   If you add reference types to a `struct` (which is possible)
///   breaks the `copy` value type semantics of structures. 
///
/// * You don't need to inherit properties or behavior
///   from another structure.
///
///
/// Structures are given a default "memberwise initializer".
/// A memberwise initializer is a compiler-generated initializer that you can use to create
/// a new instance of the struct, fully populated with initial values.
///
/// - important: Memberwise initializers are created with parameters which match the order
///              in which properties are declared. For example, the generated memberwise
///              initializer for `point` is:
///
///         Point p = Point(x: 1, y: 2)
///
///
/// - important: Changing the order of a structures properties will break callers of the default memberwise initializer.
///              It's probably better for you to define your own initializers rather than relying on the compiler default.
///
struct Point : Equatable  {
    
    var x: Int
    var y: Int
    
    /// `type methods` can be declared with the `static` keyword.
    static func copy(_ point: Point) -> Point {
        return Point(x: point.x, y: point.y)
    }
    
    ///
    /// A `convenience` initializer which creates a point with 
    /// the same `x` and `y` values.
    ///
    /// Convenience initializers are not annoated with `convenience` 
    /// in `struct`s like they are in classes.
    ///
    init(val : Int) {
        self.init(x: val, y: val)
    }

    /// Because we provide an initializer above, the compiler will
    /// not generate a default memberwise initializer.
    init(x : Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    /// 
    /// By default, structs and enums are immutable. In general,
    /// structs should stay immutable and should not be mutated.
    ///
    /// You can opt into allowing your struct / enum value type to be mutated.
    ///
    /// `mutating` allows you to mutate `var` struct members.
    ///
    mutating func offsetBy(_ x: Int, y: Int) {
        
        // mutating functions could also assign an entirely new instance to `self`
        // self = Point(x: self.x + x, y: self.y + y)
        
        // mutating functions could also update `var` properties.
        self.x += x
        self.y += y
    }

    /// Conform to the equatable protocol.
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

}


