//
//  Pass_lms_Class.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 18..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol Pass_lms_Delegate;



@interface Pass_lms_Class : NSObject<NSURLConnectionDataDelegate>

//인증시 html파싱
- (void)sendUserToken:(NSString *)token Value:(NSString *)value Url:(NSString *)class_url;

-(void)start_ParseUrl:(NSString *)class_url;

@property id<Pass_lms_Delegate> delegate;
@property (nonatomic, strong) void(^blockAfterUpdate)(void);


@end

@protocol Pass_lms_Delegate

-(void)compliteParsing_return_url:(NSString *)url;

@optional
-(void)failParsingForLmsClass;

@end
