//
//  Add_Student_Name.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 13..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Class_Url_Select.h"
#import "Class_Url_Make.h"
#import "Pass_lms_Class.h"
#import "Board_Url_1.h"
#import "Board_Url_2.h"

@class Pass_lms_Class;
@class Class_Url_Select;
@class Class_Url_Make;
@class Board_Url_1;

@interface Add_Student_Name : UIViewController<UITextFieldDelegate, Class_Delegate, Pass_lms_Delegate, Class_Make_Delegate, Board_1_delegate, Board_2_delegate>

@end
