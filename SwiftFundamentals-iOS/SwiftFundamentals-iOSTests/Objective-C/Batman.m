//
//  Batman.m
//  objc-fundamentals
//
//  Created by Damon Allison on 9/22/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

#import "Batman.h"

@implementation Batman

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
                       superPower:(int)superPower {
    if (self = [super initWithFirstName:firstName lastName:lastName]) {
        _superPower = superPower;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Batman <%p> firstName:(%@) lastName:(%@) superPower:(%d)",
            self, self.firstName, self.lastName, self.superPower];
}

@end
