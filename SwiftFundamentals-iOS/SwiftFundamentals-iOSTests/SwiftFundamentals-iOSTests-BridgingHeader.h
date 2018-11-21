//
//  SwiftFundamentals-iOSTests-BridgingHeader.h
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 10/30/18.
//  Copyright © 2018 Damon Allison. All rights reserved.
//

/**
 * A bridging header exposes Objective-C objects to Swift.
 *
 * 1. #import every header that you want to expose to swift.
 * 2. Set the SWIFT_OBJC_BRIDGING_HEADER build setting to the location of this file.
 * 3. Use the object from your .swift code!
 */

#ifndef SwiftFundamentals_iOSTests_BridgingHeader_h
#define SwiftFundamentals_iOSTests_BridgingHeader_h

#import "NSString+DRAFormatting.h"

#import "Batman.h"
#import "GCDTest.h"
#import "Person.h"
#import "ObjcClass.h"
#import "ProtocolInheritanceExample.h"
#import "Queue.h"
#import "Runtime.h"

#endif /* SwiftFundamentals_iOSTests_BridgingHeader_h */
