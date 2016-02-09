//
//  Point.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 2/8/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

///
/// Example structure.
///
/// * Structures should be kept small.
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
/// * `struct`s should be relatively small and used only for 
///   small, value type data structures. Classes are the primary 
///   data structure in swift.
///
/// Structures are given a default "memberwise initializer". A memberwise initializer is a compiler-generated initializer that you can use to create a new instance of the struct, fully populated with initial values.
///
/// - important: Memberwise initializers are created with parameters which match the order in which properties are declared. For example, the generated memberwise initializer for `point` is:

///
///         Point p = Point(x: 1, y: 2)
///
///
/// - important: Changing the order of a structures properties will break callers of the memberwise initializers.
///
struct Point : Equatable  {
    
    var x: Int
    var y: Int
    
    
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
    
    init(x : Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    /// `mutating` allows you to mutate `var` struct members.
    mutating func offsetBy(x: Int, y: Int) {
        self.x += x
        self.y += y
    }
}

///
/// Conform to the equatable protocol. 
/// 
/// It seems that this function needs to be declared in the global scope (yuk!).
///
func ==(lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
