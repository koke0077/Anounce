//
//  School_News_List.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 27..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "News_List_Get.h"

@class News_List_Get;
@interface School_News_List : UIViewController<NewsListGetDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *news_Url_1;
@property (strong, nonatomic) NSString *school_url_1;
@property (strong, nonatomic) NSString *school_name_ok;

@end
