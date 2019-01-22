//
//  ObjcClass.h
//  swift-fundamentals
//
//  Created by Damon Allison on 6/26/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

///
/// @import vs. #import vs. #include
///
///
/// tl;dr -
/// * Use @import for frameworks
/// * Use #import for Objective-C and Objective-C++ headers.
/// * Use #include for C and C++ headers (for backward compatibility).
///
/// The reason we don't use #import for C and C++ headers is because #import prevents future
/// inclusions. C and C++ code may depend on being included multiple times. Using #import may
/// lead to hard to track down compilation bugs.
///
///
/// There are multiple ways to make functionality available within a file.
/// Since Objective-C is a superset of C, Objective-C began with what C provided: #include.
///
/// Over time, Objective-C implemented a better version of C's #include called #import. The
/// clang team then introduced modules into the LLVM compiler, and thus @import was born.
///
/// #include
///
/// #include "MyHeader.h"
///
/// #include was the original C way of importing a header. #include was very naive. It
/// would simply copy the entire header into your file during compilation. This lead to
/// problems. If header references were cyclic (A.h includes B.h - B.h includes A.h), you'd
/// have to write guard statements to prevent recursive importing.
///
/// In order to prevent against cycles, you'd have to write header guards in each .h file.
///
/// #ifndef _MY_HEADER_FILE
/// #define _MY_HEADER_FILE
/// /* body of header file */
/// #endif
///
/// #import
///
/// #import <Foundation/Foundation.h>
///
/// #import is a minor improvement over #include. It still copies header files at compile time,
/// but cyclic references are avoided. There are still issues with #import - for example, a function
/// you are importing overriding a function declared elsewhere.
///
/// Import has two forms: "Local" and "Global". In general, for files included in your projects,
/// use the Local form. For files in Frameworks and Libraries, use the Global form.
///
///   #import "MyHeader.h"
///
/// Global includes are found somewhere on the import path (see: HEADER_SEARCH_PATHS and USER_HEADER_SEARCH_PATHS)
///
///   #import <Foundation/Foundation.h>
///
/// @import
///
/// @import imports a module. Modules do not copy/paste into source code. There is no need
/// for the compiler to parse headers. When the compiler sees an `@import` module import, it loads
/// a binary representation of the model, making the entire module API available to the application.
///
/// * Modules are precompiled (binary). Linking happens against a compiled version of the module, so
///   no text replacement is done. The problems with header replacement are avoided.
///
/// * Links the module into your application automatically. You don't need to add the framework
///   to your project.
///
/// * Modules allow you to include only a certain portion of the module in your code.
///
///  @import Foundation.NSString;
///
/// Modules are part of clang. Read Clang's modules documentation for more information:
/// https://clang.llvm.org/docs/Modules.html
///
///
/// ------------------------------------------------------------------------------------------------
///
///
/// Precompiled Headers
///
/// Precompiled headers were an attempt to speed up build times. The .pch was compiled only once
/// and included in each file automatically. .pch did two things:
///
/// * Speed up build times.
/// * Made common functionality available everywhere, without having to manually #import
///   in each file.
///
/// In practice, .pch files were abused. Everything was put into the .pch. While this is
/// convenient at first, over time it became difficult to understand where classes / functions
/// are imported from and what functionality is available to each file.
///


@import Foundation;
@import CoreGraphics;

/**
 NS_ENUM is the preferred way to create enumerations. Constants without explicit values will
 be assigned sequentially, starting from 0.
 
 Prior to NS_ENUM, there were multiple ways to specify enums.
 
 In this example, the Gender enum was created without a corresponding type. `int` is assumed.
 
 typedef enum {
   GenderUnknown,
   GenderMale,
   GenderFemale
 } Gender;

 In this example, the Gender enum was created and a type is assigned (NSInteger), however the
 compiler cannot relate the enum to the type.
 
 typedef enum {
   GenderUnknown,
   GenderMale,
   GenderFemale
 };
 
 typedef NSInteger Gender;
 
 
 The NS_ENUM macro create a new type (Gender), assigning it to the underlying storage type (NSInteger).
 This allows the compiler to type check the variable uses and check for `switch` statement completion.
 */

typedef NS_ENUM(NSInteger, Gender) {
    GenderUnknown,  /* Implied == 0 */
    GenderMale,     /* Implied == 1 */
    GenderFemale    /* Implied == 2 */
};


/**
 NS_OPTIONS is similar to NS_ENUM, however the generated values are bitwise friendly.
 */
typedef NS_OPTIONS(NSInteger, Preferences) {
    PreferencesDarkMode,        /* Implied 0 */
    PreferencesFormal,          /* Implied 1 << 0 */
    PreferencesNotifications,   /* Implied 1 << 1 */
    PreferencesAfternoon        /* Implied 1 << 2 */
};

@interface ObjcClass : NSObject


- (nonnull instancetype) initWithFirstName:(nonnull NSString *)firstName lastName:(nonnull NSString *)lastName NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, nonnull) NSString *firstName;
@property (nonatomic, strong, nonnull) NSString *lastName;

@property (nonatomic, readonly, nonnull) NSString *fullName;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, assign) Preferences preferences;

/**
 * Returns the number of times `fullName` was called across all instances.
 *
 * Demonstrates the use of static variables.
 */
+ (NSInteger) fullNameCallCount;

@end
