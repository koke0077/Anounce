//
//  AppDelegate.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 9..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *school_name;
@property (strong, nonatomic) NSString *school_url;
@property (strong, nonatomic) NSString *school_grade;
@property (strong, nonatomic) NSString *school_class;
@property (strong, nonatomic) NSString *stu_name;
@property (strong, nonatomic) NSString *school_code;
@property (strong, nonatomic) NSString *school_code_noncode;
@property (strong, nonatomic) NSString *food_url;
@property (strong, nonatomic) NSString *lms_url;
@property (strong, nonatomic) NSString *news_url;
@property (strong, nonatomic) NSString *school_course;
@property int edit_ok;
@property int is_str;
@property (strong, nonatomic) NSArray *food_array;
@property (strong, nonatomic) NSDictionary *modi_dic;
@property (strong, nonatomic) NSString *class_url;
@property BOOL is_pass;

@end

