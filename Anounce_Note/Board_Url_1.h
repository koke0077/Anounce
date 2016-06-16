//
//  Board_Url_1.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 20..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol Board_1_delegate;

@interface Board_Url_1 : NSObject<NSURLConnectionDataDelegate>

-(void)parsingWithUrl:(NSString *)url School:(NSString *)school_url;

@property id<Board_1_delegate> delegate;

@end

@protocol Board_1_delegate

-(void)complite_Board_Parsing:(NSString *)url;

@end
