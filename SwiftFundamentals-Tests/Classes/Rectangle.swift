//
//  Rectangle.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 2/9/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

///
/// A global function to make `Rectangle` conform to `Equatable`
///
func ==(lhs: Rectangle, rhs: Rectangle) -> Bool {
    return lhs.height == rhs.height &&
        lhs.width == rhs.width &&
        lhs.origin == rhs.origin
}


class Rectangle : Equatable {
    
    /// Type properties are associated with the type itself.
    static let defaultSize =  4
    
    // TODO: add a type property here
    
    // "private" means "anyone in this file can access this member" - it is *not*
    // tied to type hierarchy, rather by file.
    private var internalOrigin: Point
    
    var height: Int
    var width: Int
    
    init(origin: Point, height: Int, width: Int) {
        self.internalOrigin = origin
        self.height = height
        self.width = width
    }
    
    /// 
    /// `origin` is a "computed property". A computed property does not have a backing variable.
    ///
    var origin : Point {
        get {
            return self.internalOrigin
        }
        set {
            self.internalOrigin = newValue
        }
    }
}