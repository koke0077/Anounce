//
//  ShowViewContents.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 21..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lms_Content_Get.h"
#import "Note_Content_Get.h"

@class Lms_Content_Get;
@class Note_Content_Get;

@interface ShowViewContents : UIViewController<LmsContentDelegate, NoteContentDelegate>

@property NSString *con_url;
@property NSString *title_txt;

@end
