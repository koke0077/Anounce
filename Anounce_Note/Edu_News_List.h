//
//  Edu_News_List.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EduNewsListDelegate;

@interface Edu_News_List : NSObject

-(void)parsingWithEduNewsWith:(NSString *)url;

@property id<EduNewsListDelegate> delegate;

@end

@protocol EduNewsListDelegate

-(void)compliteLoadNewsListWithTitle:(NSArray *)title NewsUrl:(NSArray *)newsUrl;

@optional
-(void)failLoadNew;

@end
