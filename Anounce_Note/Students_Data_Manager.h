//
//  Students_Data_Manager.h
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 11..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Students_Data_Manager : NSObject

-(void)addDataWithName:(NSString *)name
                School:(NSString *)school
                 Grade:(NSString *)grade
                 Class:(NSString *)class_num
            School_Url:(NSString *)school_url
              Food_Url:(NSString *)food_url
              Note_Url:(NSString *)note_url
              News_Url:(NSString *)news_url;

-(void)removeDataWithStudents_Namd:(NSString *)name;

-(void)upDateWithName:(NSString *)name
               School:(NSString *)school
                Grade:(NSString *)grade
                Class:(NSString *)class_num
           School_Url:(NSString *)school_url
             Food_Url:(NSString *)food_url
             Note_Url:(NSString *)note_url
             News_Url:(NSString *)news_url
                RowId:(int)rowid;

-(NSArray *)getRecords;

-(NSString *)getSchoolUrlBySchool_name:(NSString *)school_name;




@end
