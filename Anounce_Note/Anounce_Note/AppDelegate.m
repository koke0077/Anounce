//
//  AppDelegate.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 9..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "AppDelegate.h"
#import <sqlite3.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize school_class, school_grade, school_name, stu_name, school_code, food_url, lms_url, news_url, school_code_noncode, food_array, school_course, edit_ok, modi_dic, is_str, class_url, is_pass;


- (NSString *)getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"school_data13.sqlite"];
}

- (NSString *)getDBPath2 {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
}

- (NSString *)getDBPath3 {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"high_school_data2.sqlite"];
}

-(void)initDB{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    NSLog(@"%@",dbPath);
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"school_data13.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:nil];
        
        if (!success) NSLog(@"데이터베이스 파일 복사 실패.");
    }
}

-(void)initDB3{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbPath = [self getDBPath3];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    NSLog(@"%@",dbPath);
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"high_school_data2.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:nil];
        
        if (!success) NSLog(@"데이터베이스 파일 복사 실패.");
    }
}

-(void)initDB2{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbPath = [self getDBPath2];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
//    NSLog(@"%@",dbPath);
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:nil];
        
        if (!success) NSLog(@"데이터베이스 파일 복사 실패.");
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self initDB];
    [self initDB2];
    [self initDB3];
    
    school_name = @"";
    school_grade = @"";
    school_class = @"";
    stu_name = @"";
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
