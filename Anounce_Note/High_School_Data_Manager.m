//
//  High_School_Data_Manager.m
//  Anounce_Note
//
//  Created by sung jun kim on 2018. 4. 24..
//  Copyright © 2018년 kimsung jun. All rights reserved.
//

#import "High_School_Data_Manager.h"

#import <sqlite3.h>
static sqlite3 *database = nil;

@implementation High_School_Data_Manager

- (NSString *)getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"high_school_data2.sqlite2"];
}

-(NSArray *)loadDataWithSchool2:(NSString *)region{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"high_school_data2.sqlite"];
    
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    
    NSMutableArray * infoArray = [NSMutableArray array];
    
    NSString *strSQL = [NSString stringWithFormat:@"SELECT s_name From high_school where s_local='%@'",region];
    
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
@end
