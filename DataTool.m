//
//  DataTool.m
//  RongYunDemo
//
//  Created by duanpeng on 17/4/20.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import "DataTool.h"

#define DATABASE_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:@"/RongYunChat.db"]

@implementation DataTool

+ (DataTool *)shareManager{
    static DataTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
        manager.queue = [FMDatabaseQueue databaseQueueWithPath:DATABASE_PATH];
        NSLog(@"Path: %@",DATABASE_PATH);
    });
    return manager;
}

- (BOOL)tableExists:(NSString *)tableName
{
    __block BOOL success = NO;
    [self.queue inDatabase:^(FMDatabase *db)   {
        success = [db tableExists:tableName];
    }];
    return success;
}

- (BOOL)createTable:(NSString *)sql
{
    return [self executeUpdate:sql args:nil];
}

- (BOOL)remove:(NSString *)table
{
    NSAssert(table, @"table cannot be nil!");
    return [self remove:table where:@"1=1"];
}

- (NSMutableArray *)select:(NSString *)table where:(NSString *)where
{
    __block NSMutableArray *users = [[NSMutableArray alloc] init];
    [self.queue inDatabase:^(FMDatabase *db)   {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@", table, where];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            [users addObject:[rs resultDictionary]];
        }
    }];
    return users;
}

- (NSMutableArray *)select:(NSString *)table
{
    NSAssert(table, @"table cannot be nil!");
    return [self select:table where:@"1=1"];
}

- (BOOL)insert:(NSString *)sql
{
    NSAssert(sql, @"sql cannot be nil!");
    return [self executeUpdate:sql args:nil];
}

- (BOOL)update:(NSString *)sql
{
    NSAssert(sql, @"sql cannot be nil!");
    return [self executeUpdate:sql args:nil];
}

- (BOOL)remove:(NSString *)table where:(NSString *)where
{
    NSAssert(table && where, @"table or where cannot be nil!");
    NSString *sql = [[NSString alloc] initWithFormat:@"DELETE FROM %@ WHERE %@", table, where];
    return [self executeUpdate:sql args:nil];
}

- (NSInteger)totalRowOfTable:(NSString *)table where:(NSString *)where
{
    NSAssert(table && where, @"table or where cannot be nil!");
    
    __block NSInteger totalRow = 0;
    [self.queue inDatabase:^(FMDatabase *db)   {
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT COUNT(*) totalRow FROM %@ WHERE %@", table, where]];
        while ([rs next]) {
            totalRow = [[rs resultDictionary][@"totalRow"] integerValue];
        }
    }];
    return totalRow;
}

#pragma mark - 私有方法
- (BOOL)executeUpdate:(NSString *)sql args:(NSArray *)args;
{
    __block BOOL success = NO;
    [self.queue inDatabase:^(FMDatabase *db)   {
        success = [db executeUpdate:sql withArgumentsInArray:args];
    }];
    return success;
}




@end
