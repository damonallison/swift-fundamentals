//
//  Person.h
//  objc-fundamentals
//
//  Created by Damon Allison on 9/22/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

@import Foundation;

#import "ProtocolInheritanceExample.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject <NameProtocol>

- (instancetype)initWithFirstName:(NSString *)firstName
                         lastName:(NSString *)lastName;

@property (nonatomic, readonly, copy) NSString *firstName;
@property (nonatomic, readonly, copy) NSString *lastName;

@property (nonatomic, readonly, getter=isOld) bool old;

@end

NS_ASSUME_NONNULL_END
