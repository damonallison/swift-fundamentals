//
//  NSError-Tests.m
//  SwiftFundamentals-iOSTests
//
//  Created by Damon Allison on 11/21/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

@import Foundation;
@import XCTest;

#import "Constants.h"

@interface NSErrorTests : XCTestCase
@end

/**
 NSError is used to represent a problem occurred during execution.
 
 An NSError has:
 
 * Numeric `code`. An `int` representing the actual error which occurred. If you are creating
   a new NSError instance yourself, you are free to choose any error `code` value.
 
 * Domain. The domain allows you to create an error within a "category" (or domain), allowing
   the caller to handle all errors of a particular domain. Domain should be in reverse-DNS form.

   `com.companyName.appOrFrameworkName.ErrorDomain`
 
 * Description. A human readable string describing the error.
 
 * UserInfo. An NSDictionary of relevant information related to the error.
 
 */
@implementation NSErrorTests

/**
 It is typically best practice to accept an NSError reference. (NSError **)
 
 Passing errors by reference allows the caller to pass in an error object. If the caller passes in
 `nil`, they don't want to deal with the error.
 
 (NSError **) parameters, by convention, should always come last.
 */
- (void) returnNSErrorIfGreaterThanZero:(NSInteger)value error:(NSError **)error {
    
    if (value > 0) {
        if (error != nil) {
            *error = [NSError errorWithDomain:DRAErrorDomain code:1 userInfo:@{
                                                                               @"firstName" : @"damon",
                                                                               @"lastName" : @"allison",
                                                                               @"age" : @42
                                                                               }];
            return;
        }
    }
}

- (void) testReturnNSError {
    
    // If you are not interested in any return error (*you should be*) you can pass NULL.
    [self returnNSErrorIfGreaterThanZero:1 error:NULL];
    
    NSError *error;
    [self returnNSErrorIfGreaterThanZero:1 error:&error];
    
    XCTAssertNotNil(error);
    
    XCTAssertEqualObjects(@"com", [error.domain substringToIndex:3]);
    XCTAssertEqual(1, error.code);
    
}

/**
 Objective-C has @try, @catch, @finally and @throw for working with exceptions.
 
 Exceptions in Objective-C are for *programmer* exceptions and should *not* be used in typical
 Objective-C code. These exceptions should be caught by programmers during development, not in
 production code.
 
 If you are calling code that *could* cause an exception, and for some reason you can't
 guard against the exception being thrown, you can use @try, @finally.
 
 For example, NSArray throws an NSException when attempting to access an element out of bounds.
 Rather than using @try / @catch, you should perform a bounds check before accessing the element.
 
 */

- (void) throwAnException {
    
    @throw [NSException exceptionWithName:@"test" reason:@"Out of bounds" userInfo:nil];
}
- (void) testNSException {
    
    bool finallyRan;
    
    @try {
        [self throwAnException];
        XCTFail(@"An exception should have been thrown...");
    }
    @catch (NSException *ex) {
        XCTAssertEqualObjects(@"test", ex.name);
    }
    @finally {
        finallyRan = YES;
    }
    XCTAssertTrue(finallyRan);
}
@end
