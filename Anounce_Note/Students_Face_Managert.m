//
//  Students_Face_Managert.m
//  Anounce_Note
//
//  Created by kimsung jun on 2015. 5. 22..
//  Copyright (c) 2015년 kimsung jun. All rights reserved.
//

#import "Students_Face_Managert.h"
#import <sqlite3.h>
static sqlite3 *database = nil;

@implementation Students_Face_Managert

-(void)addWithImageData:(NSData *)img_data ByName:(NSString *)name{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement=NULL;
    
    char *sql = "INSERT INTO face_data (name, img_data) VALUES(?,?)";
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_blob(statement, 2, [img_data bytes], (int)[img_data length], SQLITE_TRANSIENT);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);

}

-(void)updateWithImageData:(NSData *)img_data ByName:(NSString *)name{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement=NULL;
    
    char *sql = "update face_data set name=?, img_data=? where name=?";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"데이터 업데이트 오류");
    }else{
        
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_blob(statement, 2, [img_data bytes], (int)[img_data length], SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [name UTF8String], -1, SQLITE_TRANSIENT);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"업데이트 저장에러");
        }
        
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(void)removeFaceWithStudents_Namd:(NSString *)name{
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_School_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    char *sql4 = "DELETE FROM face_data WHERE name=?";
    if (sqlite3_prepare_v2(database, sql4 , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"삭제 오류");
        }
    }
    
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
}

-(NSArray *)get_FaceImage{
    
    
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
    
    char *sql = "SELECT name, img_data FROM face_data";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)],@"name",
                                 [NSData dataWithBytes:sqlite3_column_blob(statement, 1) length:sqlite3_column_bytes(statement, 1)],@"img_data", nil];
            
            [Result addObject:dic];
            
        }
    }
    
    return Result;
}

@end
