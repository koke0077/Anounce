//
//  School_News_Show.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News_Contents_Get.h"

@class News_Contents_Get;

@interface School_News_Show : UIViewController<NewsContentsGetDelegate, UIDocumentInteractionControllerDelegate>


@property (strong, nonatomic) NSString *myContents_url;
@property (strong, nonatomic) NSString *myTitle;
@property (strong, nonatomic) NSString *str_title;
@property (strong, nonatomic) NSString *school_url;

@end
