//
//  Class_Url_Select.h
//  Test_HtmlParsing
//
//  Created by kimsung jun on 2015. 4. 6..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Class_Url_Make.h"
//@class Class_Url_Make;
@protocol  Class_Delegate;
@interface Class_Url_Select : NSObject<NSURLConnectionDataDelegate>

@property id<Class_Delegate> delegate;

-(void)is_gen:(NSString *)str;

@end

@protocol Class_Delegate

-(void)completeClassParsing:(NSString *)note_url Is_On:(BOOL)is_on;

@optional
-(void)failParsing;

@end
