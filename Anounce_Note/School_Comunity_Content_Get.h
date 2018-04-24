//
//  School_Comunity_Content_Get.h
//  Anounce_Note
//
//  Created by sung jun kim on 2018. 4. 16..
//  Copyright © 2018년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ComunityContentDelegate;

@interface School_Comunity_Content_Get : NSObject

-(void)parsingWithComunityUrl:(NSString *)comunity_url;

@property id<ComunityContentDelegate> delegate;

@end

@protocol ComunityContentDelegate

-(void)compliteGetComunityTitle:(NSString *)com_title Contents:(NSString *)contents Files:(NSArray *)files;

@optional
-(void)failedGetContent;

@end
