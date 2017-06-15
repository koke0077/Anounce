//
//  School_Data_Manager.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 10..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "School_Data_Manager.h"
#import <sqlite3.h>
static sqlite3 *database = nil;

@implementation School_Data_Manager

- (NSString *)getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"school_data10.sqlite"];
}

- (NSArray*)loadDataWithSchool:(NSString *)schoolname{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data10.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray * infoArray = [NSMutableArray array];

    NSString *strSQL = [NSString stringWithFormat:@"SELECT Name From schools where Name like '%@%%%%'",schoolname];

    sqlite3_stmt *statement;
    
     NSString *name;
    
    if (sqlite3_prepare_v2(database, [strSQL UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {

           

                    name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            [infoArray addObject:name];
            }
        
        }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return infoArray;
}

- (NSArray*)loadDataWithSchool2:(NSString *)region{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data10.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    
    NSMutableArray * infoArray = [NSMutableArray array];
    
    NSString *strSQL = [NSString stringWithFormat:@"SELECT Name From schools where Region ='%@'",region];
   
    sqlite3_stmt *statement;
    NSString *name;
    
    if (sqlite3_prepare_v2(database, [strSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return infoArray;

}

- (NSString*)loadDataWithSchool_Url:(NSString *)schoolname{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data10.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
//    NSMutableArray * infoArray = [NSMutableArray array];
    
    NSString *strSQL = [NSString stringWithFormat:@"SELECT Web_Address From schools where Name = '%@'",schoolname];
    
    sqlite3_stmt *statement;
    
    NSString *name;
    
    if (sqlite3_prepare_v2(database, [strSQL UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            
            
            name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
//            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return name;
}

-(int)getSchoolCount{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data10.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return 0;
    }
    
    NSString *strSQL = @"SELECT COUNT(no) FROM schools";
    
    sqlite3_stmt *statement;
    
    int cnt;
    
    if (sqlite3_prepare_v2(database, [strSQL UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            cnt = sqlite3_column_int(statement, 0);
            
//            NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno"
            
//            cnt = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            //            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return cnt;
    
}

- (NSArray*)loadAllDataWithSchool:(NSString *)schoolname{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data10.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray * infoArray = [NSMutableArray array];
    
    NSString *strSQL = [NSString stringWithFormat:@"SELECT * From schools where Name = '%@'",schoolname];
    
    sqlite3_stmt *statement;
    
//    NSString *name;
    
    if (sqlite3_prepare_v2(database, [strSQL UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"no",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],@"Region",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"Name",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)],@"Web_Address",
                                 nil];
            
            [infoArray addObject:dic];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return infoArray;
    
}

-(void)upDateWithWithNo:(int)no
                 Region:(NSString *)region
                   Name:(NSString *)name
            Web_Address:(NSString *)web_address{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data10.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    
    char *sql = "update schools set no=?, Region =?, Name=?, Web_Address=? where Name=?";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"데이터 업데이트 오류");
    }else{
        
        sqlite3_bind_int(statement, 1, no);
        sqlite3_bind_text(statement, 2, [region UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [web_address UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [name UTF8String], -1, SQLITE_TRANSIENT);

        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"업데이트 저장에러");
        }
        
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(void)addDataWithNo:(int)no
              Region:(NSString *)region
                Name:(NSString *)name
         Web_Address:(NSString *)web_address{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data10.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    
    char *sql = "INSERT INTO schools (no, Region, Name, Web_Address) VALUES(?,?,?,?)";
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_int(statement, 1, no);
        sqlite3_bind_text(statement, 2, [region UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [web_address UTF8String], -1, SQLITE_TRANSIENT);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
}

-(int)exist_SchoolName:(NSString *)name{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data10.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return 0;
    }
    
    sqlite3_stmt *statement;
    
    NSString *strSql = [NSString stringWithFormat:@"SELECT EXISTS(select Name from schools where Name='%@')",name];
    
    int exist_data;
    
    
    if (sqlite3_prepare_v2(database, [strSql UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            exist_data = sqlite3_column_int(statement, 0);
            
            //            NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno"
            
            //            cnt = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            //            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return exist_data;

}

-(int)exist_RegionName:(NSString *)region{
    
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data10.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return 0;
    }
    
    sqlite3_stmt *statement;
    
    NSString *strSql = [NSString stringWithFormat:@"SELECT EXISTS(select Region from schools where Region='%@')",region];
    
    int exist_data;
    
    if (sqlite3_prepare_v2(database, [strSql UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            exist_data = sqlite3_column_int(statement, 0);
            
            //            NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno"
            
            //            cnt = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            //            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return exist_data;

}

-(int)exist_School:(NSString *)name Region:(NSString *)region{
    
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"school_data10.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return 0;
    }
    
    sqlite3_stmt *statement;
    
    NSString *strSql = [NSString stringWithFormat:@"SELECT EXISTS(select * from schools where Region='%@' AND Name='%@')",region,name];
    
    int exist_data=0;
    
    if (sqlite3_prepare_v2(database, [strSql UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            exist_data = sqlite3_column_int(statement, 0);
            
            //            NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno"
            
            //            cnt = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            
            //            [infoArray addObject:name];
        }
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return exist_data;
    
}
//Select exists(select * from schools where Name='아라초등학교' And Region='함안');
@end
