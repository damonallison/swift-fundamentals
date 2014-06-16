//
//  MemoryManagement.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/11/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import Foundation



//
// Memory Management
//

//
// An apartment can have a tenant and a tenant can have an apartment.
// If we are not careful with how we structure the Apartment / Tenant relationship,
// the following will create a cycle between a tenant<->apartment.
//

func testMemoryManagement() {
    var a = Apartment(aptNum: 100)
    var t = Tenant(apartment: a)
    t.firstName = "renter"
}


//
// There are three types of references in swift:
//
// Strong  - Default - use most of the time (most objects own others)
//
// Weak    - Casual relationships (must be optional values)
//
// Unowned - Back references back up to their owners.
//           If the owner is deallocated, the child is deallocated.
//

//
// Weak references (must be optional values)
//
// The problem with weak is that the variable could
// be released at any point. 
//
// Weak references are not always ideal, since you 
// don't want to use an optional or you want an immutable value.
// 


class Tenant {
    var firstName: String?
    var lastName: String?

    //
    // A tenant *requires* an apartment, therefore it cannot be a weak
    // reference. When this tenant and the associated apartment are 
    // set to nil, both objects will be deallocated (unowned broke the 
    // cycle).
    //
    unowned var apartment: Apartment

    init(apartment: Apartment) {
        self.apartment = apartment
    }
}


class Apartment {
    var aptNum: Int
    var tenant: Tenant?

    init(aptNum: Int) {
        self.aptNum = aptNum
    }
}