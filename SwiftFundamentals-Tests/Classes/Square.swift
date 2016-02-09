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
    
    // TODO: override `height` and `width` to enforce a side must be >= 0 && height == width
    
}

