//
//  Board_Url_2.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 20..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Board_2_delegate;

@interface Board_Url_2 : NSObject<NSURLConnectionDataDelegate>

@property id<Board_2_delegate> delegate;

-(void)parsingWithUrl2:(NSString *)url School:(NSString *)school_url;

@end

@protocol Board_2_delegate

-(void)complite_Board2_Parsing:(NSString *)url;

@end
