//
//  MemoryManagement.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/11/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/**
 Swift does it's best to make memory management (and pointers) as
 transparent as possible. Under the covers, ARC provides the heavy
 lifting for managing memory. ARC needs help understanding
 reference cycles from the developer. In reality, there is very
 little an engineer needs to do to manage memory in Swift.

 In this example, an apartment can have a tenant and a tenant can have an apartment.
 If we are not careful with how we structure the Apartment / Tenant relationship,
 the following will create a cycle between a tenant<->apartment.

 There are three types of references in swift:

 * Strong: The default - use most of the time (most objects own others).

 * Weak - Use a `weak` reference when when it is valid for that reference
 to become `nil` at some point. Weak references must be optionals (since
 they can become `nil`).

 Typically, you'll use a `weak` reference when the refrenced object can be
 has a shorter lifetime than the current object.`nil`

 For example, if a `Job` object references a `Person`, make the `person` reference
 `weak` on the `Job` object. It's appropriate for a job to have no person at
 some point in it's lifetime.

 * Unowned - Use an `unowned` reference when you know the reference will
 never be `nil` once it has been set during initialization.

 If the other object has the same or longer lifetime, use `unowned`.

 */

var logs: [String] = []

func log(_ s: String) -> Void {
  logs.append(s)
}

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

  deinit {
    log("Tenant is being deinitialized \(String(describing: firstName)) \(String(describing: lastName))")
  }
}


class Apartment {
  var aptNum: Int
  var tenant: Tenant?

  init(aptNum: Int) {
    self.aptNum = aptNum
  }

  deinit {
    log("Apartment is being deinitialized: \(aptNum)")
  }
}


class MemoryManagementTests : XCTestCase {


  /// We need to fix this test. The original goal was to show that deallocating
  /// 
  func fixmeTestUnownedReference() {
    let a = Apartment(aptNum: 1)
    let t = Tenant(apartment: a)

    XCTAssertEqual(t.firstName, t.apartment.tenant!.firstName)
    
    XCTAssertTrue(true, "What are we doing here")
  }

}
