//
//  Note_List_Get.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 20..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NoteListGetDelegate;

@interface Note_List_Get : NSObject

@property id<NoteListGetDelegate> delegate;

-(void)parsing:(NSString *)url School_Url:(NSString *)school;

@end

@protocol NoteListGetDelegate

-(void)compliteParsing:(NSArray *)arr_url Title:(NSArray *)arr_title;

@optional
-(void)failParsingForNoteList;
@end
