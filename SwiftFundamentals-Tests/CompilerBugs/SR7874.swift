//
//  SR7874.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 7/26/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import XCTest

/// SR7874 : Compiler crash with multiple `var` bindings.
class SR7874 : XCTestCase {

    /// Bug SR7874 : Use `let` until resolved.
    
//    func testSR7874_UnusedMultipleVarWithCondition() {
//        switch "test" {
//    case var n where n.count == 10, let n:
//            break
//        }
//    }
    
    func test_SR7874_UnusedSingleWildcardLet() {
        switch "test" {
        case let _:
            break
        default:
            XCTFail()
        }
    }
    
    func test_SR7874_UnusedSingleLet() {
        switch "test" {
        case let n:
            break
        default:
            XCTFail()
        }
    }

    func test_SR7874_UnusedSingleVar() {
        switch "test" {
        case var n:
            break
        default:
            XCTFail()
        }
    }
    
    func test_SR7874_UnusedMultipleWildcardLet() {
        switch "test" {
        case let _, let _:
            break
        }
    }
    func test_SR7874_UnusedMultipleLet() {
        switch "test" {
        case let n, let n:
            break
        }
    }
    func test_SR7874_UnusedMultipleVar() {
        switch "test" {
        case var n, var n:
            break
        }
    }
}
