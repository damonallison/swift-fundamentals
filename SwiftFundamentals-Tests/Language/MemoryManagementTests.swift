//
//  MemoryManagement.swift
//  swift-fundamentals
//
//  Created by Damon Allison on 6/11/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

import XCTest

/// Swift does it's best to make memory management (and pointers) as
/// transparent as possible. Under the covers, memory management is based on ARC.
///
/// ARC needs help understanding reference cycles from the developer.
/// In reality, there is very little an engineer needs to do to manage memory in Swift.
///
/// In this example, an apartment can have a tenant and a tenant can have an apartment.
/// If we are not careful with how we structure the Apartment / Tenant relationship,
/// the following will create a reference cycle between a Tenant <-> Apartment.
///
/// Weak and unowned references allow you to refer to an object without keeping a
/// strong hold on it.
///
///
/// There are three types of references in swift:
///
/// ## Strong
///
/// Keeps a strong reference to an object. Increases the object's reference count.
///
/// ## Weak
///
/// Use a `weak` reference when the other object has a shorter lifespan. Delegates
/// should use a `weak` reference. Weak references are *always* `var`s and always optional.
///
///         weak var delegate: TableViewDelegate?
///
///
/// ## Unowned
///
/// Use an `unowned` reference when the other object has a longer lifespan. The other
/// object should never be `nil`
class MemoryManagementTests : XCTestCase {

    class Logger {
        /// Not sure how this is going to work. If XCTest runs tests in parallel,
        /// these tests will fail.
        static var logs: [String] = []
    }

    class Tenant {
        var firstName: String
        var lastName: String
        var apartment: Apartment

        init(firstName: String, lastName: String, apartment: Apartment) {
            self.firstName = firstName
            self.lastName = lastName
            self.apartment = apartment
        }

        deinit {
            MemoryManagementTests.Logger.logs.append("Tenant is being deinitialized \(String(describing: firstName)) \(String(describing: lastName))")
        }
    }


    class Apartment {
        var aptNum: Int
        weak var tenant: Tenant?

        init(aptNum: Int) {
            self.aptNum = aptNum
        }

        deinit {
            MemoryManagementTests.Logger.logs.append("Apartment is being deinitialized: \(aptNum)")
        }
    }


    func testWeakReferences() {
        MemoryManagementTests.Logger.logs.removeAll()
        var a: Apartment? = Apartment(aptNum: 1)
        var t: Tenant? = Tenant(firstName: "test", lastName: "user", apartment: a!)
        a?.tenant = t

        // At this point, we have a reference cycle. The apartment has a strong reference to the tenant
        // and the Tenant has a strong reference to the apartment.
        //
        // When the tenant leaves, the apartment should not have it's tenant.
        // Because the apartment has a `weak` reference to it's tenant, when the tenant leaves, the tenant
        // is deallocated. If Apartment had a strong reference to it's tenant, when t = nil, the Apartment
        // reference would still exist.
        t = nil
        XCTAssertNil(a?.tenant)
        XCTAssertTrue(MemoryManagementTests.Logger.logs[0].contains("Tenant is being deinitialized"))

        a = nil
        XCTAssertTrue(MemoryManagementTests.Logger.logs[1].contains("Apartment is being deinitialized"))

    }

    /// In this example, a Customer may or may not have a credit card. But a credit card will always
    /// have a customer.
    class Customer {
        let name: String
        var card: CreditCard?

        init(name: String) {
            self.name = name
        }
        deinit {
            MemoryManagementTests.Logger.logs.append("Customer is being deinitialized")
        }
    }

    class CreditCard {
        let number: Int
        unowned let customer: Customer

        init(number: Int, customer: Customer) {
            self.number = number
            self.customer = customer
        }
        deinit {
            MemoryManagementTests.Logger.logs.append("CreditCard is being deinitialized")
        }
    }

    func testUnownedReferences() {

        MemoryManagementTests.Logger.logs.removeAll()

        var customer: Customer? = Customer(name: "damon")
        customer!.card = CreditCard(number: 1, customer: customer!)

        // Because CreditCard is not holding a strong reference to Customer, we do not have a reference cycle.
        // However, we must ensure we set the CreditCard to nil first. It is illegal to have a CreditCard without
        // a customer. If we set the customer to nil, accessing CreditCard.customer will crash the program.

        customer!.card = nil
        XCTAssertTrue(MemoryManagementTests.Logger.logs[0].contains("CreditCard is being deinitialized"))

        // Because we have no strong reference back to Customer, we can set customer to nil and it will be deallocated.
        customer = nil
        XCTAssertTrue(MemoryManagementTests.Logger.logs[1].contains("Customer is being deinitialized"))

    }

    /// A strong reference cycle can occur when you assign a closure property to a class instance
    /// and the body of the closure captures the instance (with self).
    ///
    /// This strong reference cycle occurs because closures are reference types (like objects).
    ///
    /// Swift solves this problem by allowing closure capture lists.
    func testStrongReferenceCyclesForClosures() {

        class HTMLElement {
            let name: String
            let text: String?

            /// Because this property is marked `lazy`, it does not accessed until after initialization.
            /// Therefore, you can refer to self.
            ///
            /// Without the unowned self capture, a strong reference cycle exists between the closure
            /// and self.
            ///
            /// Use unowned when the lifetime of the closure and the instance always refer to each other
            /// and will be deallocated at the same time. In this case, the closure and the instance
            /// will be deallocated together.
            lazy var asHTML: () -> String = { [unowned self /* , weak otherVar... */ ] in
                if let text = self.text {
                    return "<\(self.name)>\(text)</\(self.name)>"
                }
                else {
                    return "<\(self.name) />"
                }
            }

            /// Capturing a variable as "weak" will capture the reference as an optional.
            /// Use optional binding to check for nil, act appropriately.
            ///
            /// If the object being captured could ever be set to nil (has a shorter lifetime than the closure),
            /// capture it as weak.
            ///
            /// This is here just for an example. In this case, you'd want to use unowned.
            lazy var asHTMLWeak: () -> String = { [weak self] in
                guard let strongSelf = self else {
                    return "Unknown"
                }
                if let text = strongSelf.text {
                    return "<\(strongSelf.name)>\(text)</\(strongSelf.name)>"
                }
                else {
                    return "<\(strongSelf.name) />"
                }
            }

            init(name: String, text: String? = nil) {
                self.name = name
                self.text = text
            }

            deinit {
                MemoryManagementTests.Logger.logs.append("HTMLElement is being deinitialized")
            }
        }

        MemoryManagementTests.Logger.logs.removeAll()
        var h: HTMLElement? = HTMLElement(name: "h1")
        XCTAssertEqual("<h1 />", h?.asHTML())
        XCTAssertEqual("<h1 />", h?.asHTMLWeak())
        h = nil;

        XCTAssertTrue(MemoryManagementTests.Logger.logs[0].contains("HTMLElement is being deinitialized"))
    }

    /// This test shows a memory leak caused by a cycle.
    func testStrongReferenceCycleLeak() {

        class HTMLElementLeaky {
            let name: String
            let text: String?

            /// asHTML is a property of the object which also captures the object.
            ///
            /// This cyclic relationship will cause a memory leak.
            /// Every instance of this object which uses asHTML will leak.
            lazy var asHTML: () -> String = {
                if let text = self.text {
                    return "<\(self.name)>\(text)</\(self.name)>"
                }
                else {
                    return "<\(self.name) />"
                }
            }

            init(name: String, text: String? = nil) {
                self.name = name
                self.text = text
            }

            deinit {
                MemoryManagementTests.Logger.logs.append("HTMLElement is being deinitialized")
            }
        }

        MemoryManagementTests.Logger.logs.removeAll()
        var h: HTMLElementLeaky? = HTMLElementLeaky(name: "test")
        let _ = h!.asHTML()
        h = nil;

        XCTAssertTrue(MemoryManagementTests.Logger.logs.isEmpty)
    }



    // MARK:- Memory Safety




    /// Memory safety is lost when multiple code contexts have overlapping read and/or write access to the same variable.
    ///
    /// Guidelines:
    ///
    /// * Avoid `inout` parameters. If you do use them, ensure a function does not try to both read and write
    ///   to the parameter.
    ///
    /// * Think functionally! State is evil. Avoid mutation.
    ///
    /// `inout` parameters have write access for the duration of the function.
    /// Here, `stepSize` is both readable and writable from within `incrementInPlace`.
    ///
    /// This test will crash.
    ///
    /// Simultaneous accesses to 0x10262b5c0, but modification requires exclusive access.
    /// Previous access (a modification) started at SwiftFundamentals-Tests`MemoryManagementTests.testMemorySafety() + 123 (0x1069a109b).
    /// Current access (a read) started at:
    /// 0    libswiftCore.dylib                 0x0000000106dec650 swift_beginAccess + 511
    /// 1    SwiftFundamentals-Tests            0x00000001069a10d0 incrementInPlace #1 (_:) in MemoryManagementTests.testMemorySafety() + 76
//    func testMemorySafety() {
//
//        var stepSize = 1
//        func incrementInPlace(_ number: inout Int) {
//            number += stepSize
//        }
//        incrementInPlace(&stepSize)
//    }


}
