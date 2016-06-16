//
//  Lms_Content_Get.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 21..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LmsContentDelegate;

@interface Lms_Content_Get : NSObject

-(void)parsingToGetWithUrl:(NSString *)url;

@property id<LmsContentDelegate> delegate;

@end

@protocol LmsContentDelegate

-(void)compliteGetContents:(NSString *)contents;

@end
