//
//  EduNewsShow.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Edu_News_Get.h"

@class Edu_News_Get;

@interface EduNewsShow : UIViewController<EduNewsGetDelegate, UITextViewDelegate, UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) NSString *news_url;
@property (strong, nonatomic) NSString *news_title;
@property (strong, nonatomic) NSString *news;
@property (strong, nonatomic) NSData *img_data;

@end
