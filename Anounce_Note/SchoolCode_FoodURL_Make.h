//
//  SchoolCode_FoodURL_Make.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 13..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol School_Food_Delegate;

@interface SchoolCode_FoodURL_Make : NSObject<NSURLConnectionDataDelegate>

@property id<School_Food_Delegate> delegate;

@property int parsing_cnt;

@property (nonatomic, strong) void(^blockAfterUpdate)(void);

-(void)parseWithSchool_URL:(NSString *)school_url;
@end

@protocol School_Food_Delegate

-(void)completeParsing2:(NSString *)food_url School:(NSString *)school_code Cls_page:(NSString *)cls_page News_url:(NSString *)news_url SchoolCode:(NSString *)school_code_noncode;

@optional
-(void)failParsing;

@end
