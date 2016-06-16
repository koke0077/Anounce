//
//  Add_Grade_Class.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 13..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Grade_Get.h"
#import "Grade_Get_2.h"
//#import "NoteURL_Make.h"
//@class NoteURL_Make;

#import "SchoolCode_FoodURL_Make.h"
@class SchoolCode_FoodURL_Make;
@class Grade_Get;
@class Grade_Get_2;

@interface Add_Grade_Class : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, School_Food_Delegate, GradeGetDelegate, GradeGet2Delegate>

@end
