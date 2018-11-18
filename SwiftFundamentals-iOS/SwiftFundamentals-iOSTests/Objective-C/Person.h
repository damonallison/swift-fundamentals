//
//  Person.h
//  objc-fundamentals
//
//  Created by Damon Allison on 9/22/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProtocolInheritanceExample.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject <NameProtocol>

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName;

@property (nonatomic, readonly) NSString *firstName;
@property (nonatomic, readonly) NSString *lastName;

@end

NS_ASSUME_NONNULL_END
