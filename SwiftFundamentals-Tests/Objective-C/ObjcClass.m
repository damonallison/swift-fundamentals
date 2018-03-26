//
//  ObjcClass.m
//  swift-fundamentals
//
//  Created by Damon Allison on 6/26/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

#import "ObjcClass.h"

@implementation ObjcClass

- (instancetype) init {
    if (self = [super init]) {

    }
    return self;
}
- (instancetype) initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    if (self = [super init]) {
        self.firstName = firstName;
        self.lastName = lastName;
    }
    return self;
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"ObjcClass <%p> %@ %@", self, _firstName, _lastName];
}

@end
