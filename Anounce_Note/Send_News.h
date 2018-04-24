//
//  Send_News.h
//  Anounce_Note
//
//  Created by sung jun kim on 2018. 4. 9..
//  Copyright © 2018년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SendNewsDelegate;

@interface Send_News : NSObject

-(void)parsingWithSchoolurl:(NSString *)school_url;

@property id<SendNewsDelegate> delegate;


@end

@protocol SendNewsDelegate

-(void)compliteToGetSendNewsList:(NSString *)news_url;

@optional

//-(void)failedToGetSendNewsList;


@end
