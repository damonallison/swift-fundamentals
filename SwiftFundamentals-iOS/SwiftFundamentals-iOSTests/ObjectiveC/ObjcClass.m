//
//  ObjcClass.m
//  swift-fundamentals
//
//  Created by Damon Allison on 6/26/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

@import Foundation;

#import "ObjcClass.h"

@implementation ObjcClass

/**
 * Static variables exist for the lifetime of the program. There is only one instance of a static
 * variable, which is shared across all instances.
 *
 * Static variables can be declared outside of a function (like this one), or within a function.
 */
static int _fullNameCallCount;

- (instancetype) init {
    return [self initWithFirstName:@"Test" lastName:@"User"];
}

- (nonnull instancetype) initWithFirstName:(nonnull NSString *)firstName lastName:(nonnull NSString *)lastName {
    if (self = [super init]) {
        self.firstName = firstName;
        self.lastName = lastName;
    }
    return self;
}

- (NSString *)fullName {
    _fullNameCallCount++;
    return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
}

+ (NSInteger)fullNameCallCount {
    return _fullNameCallCount;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"ObjcClass <%p> %@ %@", self, _firstName, _lastName];
}

@end
