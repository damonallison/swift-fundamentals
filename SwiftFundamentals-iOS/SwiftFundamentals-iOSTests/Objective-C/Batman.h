//
//  Batman.h
//  objc-fundamentals
//
//  Created by Damon Allison on 9/22/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Batman : Person

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName
                       superPower:(int)superPower;

@property (nonatomic) int superPower;

@end

NS_ASSUME_NONNULL_END
