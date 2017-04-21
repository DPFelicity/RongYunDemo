//
//  DataTool+ChatUser.m
//  RongYunDemo
//
//  Created by duanpeng on 17/4/20.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import "DataTool+ChatUser.h"

@implementation DataTool (ChatUser)
- (void)initChatUser
{
    //创建聊天用户表
    [self createTable:@"CREATE TABLE IF NOT EXISTS 'ChatUserTable' ('userId' DATETIME PRIMARY KEY NOT NULL UNIQUE, 'pushToken' VARCHAR, 'userName' VARCHAR, 'photo' VARCHAR )"];
}

- (BOOL)insertWithUserId:(NSString *)userId Name:(NSString *)name PushToken:(NSString *)pushToken Photo:(NSString *)photo
{
    __block BOOL success = NO;
    [self.queue inDatabase:^(FMDatabase *db)   {
        //字符串中有'会出问题,用此方法避免
        NSString *addUser = @"INSERT OR REPLACE INTO 'ChatUserTable' ('userId','pushToken','userName','photo') VALUES (?,?,?,?)";
        success = [db executeUpdate:addUser,userId,pushToken,name,photo];
    }];
    return success;
}

- (BOOL)insertWithChatUser:(ChatUserModel *)chatUserModel
{
    return [self insertWithUserId:chatUserModel.userId Name:chatUserModel.userName PushToken:chatUserModel.pushToken Photo:chatUserModel.photo ];
}

- (void)insertChatUser:(NSArray *)chatUserArray
{
    [self.queue inDatabase:^(FMDatabase *db)   {
        for (ChatUserModel *chatUserModel in chatUserArray) {
            NSString *addUser = @"INSERT OR REPLACE INTO 'ChatUserTable' ('userId','pushToken','userName','photo') VALUES (?,?,?,?)";
            [db executeUpdate:addUser,chatUserModel.userId,chatUserModel.pushToken,chatUserModel.userName,chatUserModel.photo];
        }
    }];
}

- (ChatUserModel *)selectUserWithUserId:(NSString *)userId
{
    NSMutableArray *dataArray = [self select:@"ChatUserTable" where:[NSString stringWithFormat:@"userId = '%@'",userId]];
    for (NSDictionary *data in dataArray) {
        return [ChatUserModel initChatUserModelByDict:data];
    }
    return nil;
}
- (NSMutableArray *)selectUserWithCondition:(NSString *)condition
{
    NSMutableArray *dataArray = [self select:@"ChatUserTable" where:condition];
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    for (NSDictionary *data in dataArray) {
        ChatUserModel *chatUserModel = [ChatUserModel initChatUserModelByDict:data];
        [userArray addObject:chatUserModel];
    }
    return userArray;
}

- (void)clearChatUser
{
    [self remove:@"ChatUserTable"];
}

- (void)clearChatUserWith:(NSString *)userId{
    [self remove:@"ChatUserTable" where:[NSString stringWithFormat:@"userId = '%@'",userId]];
}
@end
