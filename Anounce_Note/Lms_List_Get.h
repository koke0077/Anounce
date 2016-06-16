//
//  Lms_List_Get.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 21..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Lms_List_Delegate;

@interface Lms_List_Get : NSObject

@property id<Lms_List_Delegate> delegate;

-(void)parsingWithUserToken:(NSString *)token Value:(NSString *)value Url:(NSString *)class_url;

-(void)nonLmsParsingUrl:(NSString *)slass_url;

@end

@protocol Lms_List_Delegate

-(void)compliteLmsParsingWithUrl_Array:(NSArray *)url_arr Tilte_Array:(NSArray *)title_array;

@end
