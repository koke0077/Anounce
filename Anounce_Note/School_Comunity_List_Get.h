//
//  School_Comunity_List_Get.h
//  Anounce_Note
//
//  Created by sung jun kim on 2018. 4. 16..
//  Copyright © 2018년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ComunityListDelegate;

@interface School_Comunity_List_Get : NSObject

-(void)parsingWithListUrl:(NSString *)list_url WithSchool_url:(NSString *)school_url;

@property id<ComunityListDelegate> delegate;

@end

@protocol ComunityListDelegate

-(void)compliteToGetComunityList:(NSArray*)title_list News_Url:(NSArray *)news_url;

@optional

-(void)failedToGetComunityList;

@end
