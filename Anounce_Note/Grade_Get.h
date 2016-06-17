//
//  Grade_Get.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 22..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GradeGetDelegate;

@interface Grade_Get : NSObject

-(void)parsingWithUrl:(NSString *)url;

@property id<GradeGetDelegate> delegate;

@end

@protocol GradeGetDelegate
//-(void)compliteGetGradeClass:(NSArray *)cls_num;

-(void)compliteGetGradeClass:(NSDictionary *)cls_num;
@optional

-(void)compliteGetGradeClass2:(NSArray *)cls_arr;

@end
