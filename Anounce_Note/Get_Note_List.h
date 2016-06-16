//
//  Get_Note_List.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 19..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Get_Note_List : NSObject<NSURLConnectionDataDelegate>

-(void)parsingWithUrl:(NSString *)url;

@end
