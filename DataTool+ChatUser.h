//
//  DataTool+ChatUser.h
//  RongYunDemo
//
//  Created by duanpeng on 17/4/20.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import "DataTool.h"
#import "ChatUserModel.h"

@interface DataTool (ChatUser)




/**
 初始化聊天用户表
 */
- (void)initChatUser;


/**
 插入单个数据信息（单个插入）

 @param userId 用户Id
 @param name 用户名
 @param pushToken 用户token
 @param photo 头像Url
 @return 返回插入状态
 */
- (BOOL)insertWithUserId:(NSString *)userId Name:(NSString *)name PushToken:(NSString *)pushToken Photo:(NSString *)photo;


/**
 插入单个数据信息（model插入）

 @param chatUserModel 用户信息model
 @return 返回插入状态
 */
- (BOOL)insertWithChatUser:(ChatUserModel *)chatUserModel;


/**
 批量添加用户信息

 @param chatUserArray 要插入的用户信息数组（数组包含model）
 */
- (void)insertChatUser:(NSArray *)chatUserArray;


/**
 根据用户Id查找用户信息model

 @param userId 要查询的Id
 @return 查询到的用户信息
 */
- (ChatUserModel *)selectUserWithUserId:(NSString *)userId;


/**
 查询用户信息

 @param condition 查询条件（sql 语句 ）
 @return 返回查询结果
 */
- (NSMutableArray *)selectUserWithCondition:(NSString *)condition;


/**
 清空聊天用户表
 */
- (void)clearChatUser;


/**
 根据Id清除单个用户

 @param userId 要清除的用户Id
 */
- (void)clearChatUserWith:(NSString *)userId;

@end
