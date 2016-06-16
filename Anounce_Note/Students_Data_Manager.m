//
//  Students_Data_Manager.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 11..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Students_Data_Manager.h"
#import <sqlite3.h>
static sqlite3 *database = nil;

@implementation Students_Data_Manager

- (NSString *)getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
}


-(void)addDataWithName:(NSString *)name
                School:(NSString *)school
                 Grade:(NSString *)grade
                 Class:(NSString *)class_num
            School_Url:(NSString *)school_url
              Food_Url:(NSString *)food_url
              Note_Url:(NSString *)note_url
              News_Url:(NSString *)news_url{
    
    
//    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement=NULL;
        
    char *sql = "INSERT INTO save_name (name, school, grade, class, school_url, food_url, note_url, news_url) VALUES(?,?,?,?,?,?,?,?)";
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [school UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [grade UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [class_num UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [school_url UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [food_url UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 7, [note_url UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 8, [news_url UTF8String], -1, SQLITE_TRANSIENT);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
}

-(void)upDateWithName:(NSString *)name
               School:(NSString *)school
                Grade:(NSString *)grade
                Class:(NSString *)class_num
           School_Url:(NSString *)school_url
             Food_Url:(NSString *)food_url
             Note_Url:(NSString *)note_url
             News_Url:(NSString *)news_url
                RowId:(int)rowid{
    
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }

    sqlite3_stmt *statement;
    
    char *sql = "update save_name set name=?, school =?, grade=?, class=?, school_url=?, food_url=?, note_url=?, news_url=? where rowid=?";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"데이터 업데이트 오류");
    }else{
        
        
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [school UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [grade UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [class_num UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [school_url UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [food_url UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 7, [note_url UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 8, [news_url UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 9, rowid);
        
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"업데이트 저장에러");
        }
        
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(void)removeDataWithStudents_Namd:(NSString *)name{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }

         sqlite3_stmt *statement;
    char *sql4 = "DELETE FROM save_name WHERE name=?";
    if (sqlite3_prepare_v2(database, sql4 , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"삭제 오류");
        }
    }
    
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(NSArray *)getRecords{
    
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [[NSMutableArray alloc]initWithCapacity:15];
    
    [Result removeAllObjects];
    
    sqlite3_stmt *statement;
    
    char *sql = "SELECT name, school, grade, class,school_url, food_url, note_url, news_url, rowid FROM save_name";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)],@"name",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],@"school",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"grade",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)],@"class",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)],@"school_url",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)],@"food_url",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)],@"note_url",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)],@"news_url",
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 8)],@"rowid", nil];
            
            [Result addObject:dic];
            
        }
    }
    
    return Result;
}
//3월 37일 수정
-(NSString *)getSchoolUrlBySchool_name:(NSString *)school_name{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    NSString *school_url;
    
    sqlite3_stmt *statement;
    
    NSString *sql_str = [NSString stringWithFormat:@"SELECT school_url FROM save_name where school='%@'", school_name];
    
    if (sqlite3_prepare_v2(database, [sql_str UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            school_url = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
        }
    }
    
    return school_url;
}


@end
