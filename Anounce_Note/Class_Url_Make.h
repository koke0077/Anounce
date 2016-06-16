//
//  Class_Url_Make.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 17..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Pass_lms_Class.h"

@protocol Class_Make_Delegate;

@interface Class_Url_Make : NSObject<NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property id<Class_Make_Delegate> delegate;

-(void)parsing:(NSString *)url;

@end

@protocol Class_Make_Delegate

-(void)CompliteParsingKey:(NSString *)key Value:(NSString *)value Lms_URl:(NSString *)lms_url;

@optional

-(void)FailedParsing_Class;

@end
