//
//  Grade_Get_2.h
//  Anounce_Note
//
//  Created by kimsung jun on 2016. 4. 27..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GradeGet2Delegate;

@interface Grade_Get_2 : NSObject

-(void)parsingWithUrl_2:(NSString *)url;

@property id<GradeGet2Delegate> delegate;

@end

@protocol GradeGet2Delegate
-(void)compliteGetGrade_2_Class:(NSArray *)cls_num;

@end