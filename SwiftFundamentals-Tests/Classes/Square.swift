//
//  Square.swift
//  SwiftFundamentals
//
//  Created by Damon Allison on 2/9/16.
//  Copyright © 2016 Damon Allison. All rights reserved.
//

///
/// A `Rectangle` which enforces height and width to be equal.
///
/// Shows:
///
/// * Inheritance
/// * Property overriding
/// * State validation
///
class Square : Rectangle {
    
    init (origin: Point, side: Int) {
        super.init(origin: origin, height: side, width: side)
    }

    /// Swift does not support throwing from a computer property 
    /// setter.
    func setSide(x: Int) {
        var sanitized = x;
        if (x < 0) {
            sanitized = 0
        }
        super.height = sanitized
        super.width = sanitized
    }
    
    override internal var height: Int {
        willSet {
            setSide(newValue)
        }
        didSet {
            print("Set side to \(height) from \(oldValue)")
        }
    }
    
    override internal var width: Int {
        willSet {
            setSide(newValue)
        }
    }

}

