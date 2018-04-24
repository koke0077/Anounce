//
//  School_Comunity_Show.h
//  Anounce_Note
//
//  Created by sung jun kim on 2018. 4. 16..
//  Copyright © 2018년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "School_Comunity_Content_Get.h"
@class School_Comunity_Content_Get;

@interface School_Comunity_Show : UIViewController<ComunityContentDelegate, UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) NSString *myContents_url;
@property (strong, nonatomic) NSString *myTitle;
@property (strong, nonatomic) NSString *str_title;
@property (strong, nonatomic) NSString *school_url;

@end
