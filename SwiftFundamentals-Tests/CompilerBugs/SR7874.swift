//
//  SR7874.swift
//  SwiftFundamentals-Tests
//
//  Created by Damon Allison on 7/26/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

import XCTest

/// SR7874 : Compiler crash with multiple "var" bindings.
class SR7874 : XCTestCase {
    
//    func test_SR7874_UnusedMultipleVarWithWhere() {
//        let name = "test"
//        switch name {
//        case var n where n.count == 10, var n where n == "test":
//            break
//        default:
//            break
//        }
//    }
    
    
    // Single `let`
    
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
    
    func test_SR7874_UnusedSingleLetWithWhere() {
        switch "test" {
        case let n where n == "test":
            break
        default:
            XCTFail()
        }
    }

    // Single `var`
    
    func test_SR7874_UnusedSigneWildcardVar() {
        switch "test" {
        case var _:
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
    
    func test_SR7874_UnusedSingleVarWithWhere() {
        switch "test" {
        case var n where n == "test":
            break
        default:
            XCTFail()
        }
    }

    
    // Multiple `let`
    
    func test_SR7874_UnusedMultipleWildcardLet() {
        switch "test" {
        case let _, let _:
            break
        default:
            XCTFail()
        }
    }
    func test_SR7874_UnusedMultipleLet() {
        switch "test" {
        case let n, let n:
            break
        default:
            XCTFail()
        }
    }

    func test_SR7874_UnusedMultipleLetWithWhere() {
        switch "test" {
        case let n where n.count == 4, let n where n == "test":
            break
        default:
            XCTFail()
        }
    }

    // Multiple `var`
    
    func test_SR7874_UnusedMultipleWildcardVar() {
        switch "test" {
        case var _, var _:
            break
        default:
            XCTFail()
        }
    }
    func test_SR7874_UnusedMultipleVar() {
        switch "test" {
        case var n, var n:
            break
        default:
            XCTFail()
        }
    }
    
    // test_SR7874_UnusedMultipleVarBindingsWithWhere() -- this is the compiler crash - see top of file.
}
