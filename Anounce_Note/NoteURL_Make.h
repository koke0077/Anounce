//
//  NoteURL_Make.h
//  Test_HtmlParsing
//
//  Created by kimsung jun on 2015. 4. 2..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.

// 알림장 주소 만들기

#import <Foundation/Foundation.h>


@protocol NoteURL_MakeDelegate;

@interface NoteURL_Make : NSObject<NSURLConnectionDataDelegate>

@property id<NoteURL_MakeDelegate> delegate;

-(void)parseWithUrl:(NSString *)school_url;

@end

@protocol NoteURL_MakeDelegate

-(void)completeParsing3:(NSString *)note_url;
@optional
-(void)failParsing;

@end


