//
//  School_Data_Manager.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 10..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface School_Data_Manager : NSObject

- (NSArray*)loadDataWithSchool:(NSString *)schoolname;

- (NSArray*)loadDataWithSchool2:(NSString *)region;

- (NSString*)loadDataWithSchool_Url:(NSString *)schoolname;

- (NSArray*)loadAllDataWithSchool:(NSString *)schoolname;

-(int)getSchoolCount;

-(void)addDataWithNo:(int)no
                Region:(NSString *)region
                 Name:(NSString *)name
                 Web_Address:(NSString *)web_address;

- (void)UpdateWithName:(NSString *)s_name
               Web_add:(NSString *)web_add;

-(void)upDateWithWithNo:(int)no
                 Region:(NSString *)region
                   Name:(NSString *)name
            Web_Address:(NSString *)web_address;


-(int)exist_SchoolName:(NSString *)name;

-(int)exist_RegionName:(NSString *)region;

-(int)exist_School:(NSString *)name Region:(NSString *)region;

@end
