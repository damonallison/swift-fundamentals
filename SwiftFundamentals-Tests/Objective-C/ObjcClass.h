//
//  ObjcClass.h
//  swift-fundamentals
//
//  Created by Damon Allison on 6/26/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

///
/// Objective-C is a superset of C.
///
/// There are multiple ways to make functionality available within a file.
///
/// #include
///
/// #include was the original C way of importing a header. #include was very naive. It
/// would simply copy the entire header into your file during compilation. This lead to
/// problems. If header references were cyclic (A.h includes B.h - B.h includes A.h), you'd
/// have to write guard statements to prevent recursive importing.
///
/// #import
///
/// #import is a minor improvement over #include. It still copies header files at compile time,
/// but cyclic references are avoided. There are still issues with #import - for example, a function
/// you are importing overriding a function declared elsewhere.
///
/// Import has two forms: "Local" and "Global". In general, for files included in your projects,
/// use the Local form. For files in Frameworks and Libraries, use the Global form.
///
/// * Local includes use double quotes and are relative to the current file.
///
///   #import "MyHeader.h"
///
/// * Global includes are found somewhere on the import path (see: HEADER_SEARCH_PATHS and
///   USER_HEADER_SEARCH_PATHS)
///
/// @import <Foundation/Foundation.h>
///
/// @import imports a module. Modules do not copy/paste into source code.
///
/// * Links the module into your application automatically. You don't need to add the framework
///   into your project.
///
/// * Modules allow you to include only a certain portion of the module in your code.
///
///  @import Foundation.NSString;
///

@import Foundation.NSString;


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

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, readonly) NSString *fullName;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, assign) Preferences preferences;

@end
