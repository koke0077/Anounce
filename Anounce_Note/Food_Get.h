//
//  Food_Get.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 21..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FoodGetDelegate;

@interface Food_Get : NSObject

-(void)parsingWithSchoolCode:(NSString *)schoolCode;

@property id<FoodGetDelegate> delegate;

@property (nonatomic, strong) NSArray *array_2;

@property (nonatomic, strong) void(^blockAfterUpdate)(void);



@end


@protocol FoodGetDelegate<NSObject>

//-(void)compliteGetFood:(NSArray *)food Day:(NSArray *)day Week:(NSArray *)week Month:(NSString *)montn_str;
-(void)compliteGetFood:(NSArray *)food_array;

@optional
-(void)failParsingForFood;

@end
