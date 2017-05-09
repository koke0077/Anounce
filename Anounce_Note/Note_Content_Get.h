//
//  Note_Content_Get.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 21..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NoteContentDelegate;

@interface Note_Content_Get : NSObject

-(void)parsingWithUrl:(NSString *)clss_url;

@property id<NoteContentDelegate> delegate;


@end

@protocol NoteContentDelegate

-(void)compliteNote:(NSString *)note_str Files:(NSArray *)files;



@end
