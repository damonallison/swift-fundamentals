//
//  StructTests.swift
//  SwiftFundamentals-iOSTests
//
//  Created by Damon Allison on 2/25/20.
//  Copyright © 2020 Damon Allison. All rights reserved.
//

import Foundation
import XCTest

class StructTests: XCTestCase {

    func testEquality() {

        /// With Swift 4.1, `enum` and `struct`, the compiler will synthetically
        /// generate conformance to `Hashable` and `Equatable` by simply declaring
        /// conformance to the desired protocol.
        ///
        /// Here, we declare conformance to `Hashable`. Swift generates conformance to
        /// `Hashable` (and thus `Equatable`) automatically for us.
        ///
        /// You can override the automatic implementation by providing your own implementations
        /// of `Hashable` or `Equatable` functions.
        ///
        /// - Important: This only works when each stored property of the struct or associated enum values
        /// are `Equatable` and/or `Hashable`.
        struct MyStruct: Hashable {
            let x, y: Int
        }
        let arr = [MyStruct(x: 1, y: 2), MyStruct(x: 2, y: 3)]

        XCTAssertTrue(arr.contains(MyStruct(x: 1, y: 2)))
    }

}
