//
//  ProtocolInheritanceExample.h
//  objc-fundamentals
//
//  Created by Damon Allison on 11/18/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

@import Foundation;

@protocol NameProtocol

@required
@property (nonatomic, readonly, copy) NSString *firstName;
@property (nonatomic, readonly, copy) NSString *lastName;

@optional
@property (nonatomic, readonly, copy) NSString *middleName;

@end

@protocol MutableNameProtocol <NameProtocol>

@required
@property (nonatomic, readwrite, copy) NSString *firstName;
@property (nonatomic, readwrite, copy) NSString *lastName;

@end


@interface ProtocolInheritanceExample : NSObject <MutableNameProtocol>

@end
