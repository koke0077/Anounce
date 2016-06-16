//
//  Edu_News_Get.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EduNewsGetDelegate;

@interface Edu_News_Get : NSObject

-(void)parsingWithUrl:(NSString *)url;

@property id<EduNewsGetDelegate> delegate;

@end

@protocol EduNewsGetDelegate

-(void)compliteGetEduNewsWithTitle:(NSString *)title Contents:(NSString *)contents Img_data:(NSData *)data;

@optional

-(void)failGetEduNews;

@end
