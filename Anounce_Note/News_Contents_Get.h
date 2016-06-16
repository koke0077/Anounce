//
//  News_Contents_Get.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsContentsGetDelegate;

@interface News_Contents_Get : NSObject

-(void)parsingWithUrl:(NSString *)news_url;

@property id<NewsContentsGetDelegate> delegate;

@end

@protocol NewsContentsGetDelegate

-(void)compliteGetContentsTitle:(NSString *)con_title Contents:(NSString *)contents Files:(NSArray *)files;

@optional

-(void)failedToGetContents;

@end
