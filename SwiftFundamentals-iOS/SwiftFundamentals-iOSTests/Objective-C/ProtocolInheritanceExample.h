//
//  ProtocolInheritanceExample.h
//  objc-fundamentals
//
//  Created by Damon Allison on 11/18/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol NameProtocol

@required
@property (nonatomic, readonly) NSString *firstName;
@property (nonatomic, readonly) NSString *lastName;

@optional
@property (nonatomic, readonly) NSString *middleName;

@end

@protocol MutableNameProtocol <NameProtocol>

@required
@property (nonatomic, readwrite) NSString *firstName;
@property (nonatomic, readwrite) NSString *lastName;

@optional
@property (nonatomic, readonly) NSString *middleName;

@end


@interface ProtocolInheritanceExample : NSObject <NameProtocol>

@property (nonatomic, readwrite) NSString *firstName;
@property (nonatomic, readwrite) NSString *lastName;

@end
