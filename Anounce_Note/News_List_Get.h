//
//  News_List_Get.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsListGetDelegate;

@interface News_List_Get : NSObject

-(void)parsingWithSchoolurl:(NSString *)list_url WithSchool_url:(NSString *)school_url;

@property id<NewsListGetDelegate> delegate;

@end

@protocol NewsListGetDelegate

-(void)compliteToGetNewsList:(NSArray *)title_list News_Url:(NSArray *)news_url;

@optional

-(void)failedToGetList;


@end
