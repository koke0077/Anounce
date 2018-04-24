//
//  School_Comunity_List.h
//  Anounce_Note
//
//  Created by sung jun kim on 2018. 4. 16..
//  Copyright © 2018년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "School_Comunity_List_Get.h"
@class School_Comunity_List_Get;

@interface School_Comunity_List : UIViewController<ComunityListDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *comunity_url;
@property (strong, nonatomic) NSString *school_url_1;
@property (strong, nonatomic) NSString *school_name_ok;

@end
