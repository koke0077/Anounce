//
//  ShowViewController.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 10..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note_List_Get.h"
#import "Class_Url_Make.h"
#import "Lms_List_Get.h"

@class Note_List_Get;
@class Class_Url_Make;
@class Lms_List_Get;

@interface ShowViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NoteListGetDelegate, Class_Make_Delegate, Lms_List_Delegate>

@property (strong, nonatomic) NSDictionary *student_dic;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Title;
- (IBAction)btn_back:(UIButton *)sender;

@end
