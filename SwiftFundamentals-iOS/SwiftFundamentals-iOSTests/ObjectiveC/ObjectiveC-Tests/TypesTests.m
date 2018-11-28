//
//  TypesTests.m
//  SwiftFundamentals-iOSTests
//
//  Created by Damon Allison on 11/26/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//
@import Foundation;
@import XCTest;

@interface TypesTests : XCTestCase
@end

/**
 Blocks are Objective-C objects. They can be stored in NSArray, or passed around
 like any other data type.
 */
@implementation TypesTests


/**
 Objective-C defines BOOL as a signed char typedef.
 
 * The value `0` is considered false, everything else is true.
 * `nil` and `NULL` are defined as `0` and are false.
 
 In Objective-C, use `BOOL` to represent boolean values (rather than C's bool)
 and the macros `YES` and `NO` to represent true / false.
 
 Swift cleans this up. It has a true boolean type and all truthy values must be of the
 boolean type.
 */
- (void)testBool {    
    XCTAssertTrue(-1);
    XCTAssertTrue(1);
    XCTAssertTrue(100);
    
    XCTAssertTrue((BOOL)-1);
    XCTAssertTrue((BOOL)1);
    XCTAssertTrue((BOOL)100);
    
    XCTAssertFalse(0);
    XCTAssertFalse((BOOL)0);
    XCTAssertFalse(nil, @"nil is defined as 0");
    XCTAssertFalse(NULL, @"NULL is defined as 0");
}

@end

