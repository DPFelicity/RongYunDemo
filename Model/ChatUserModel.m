//
//  ChatUserModel.m
//  RongYunDemo
//
//  Created by duanpeng on 17/4/20.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import "ChatUserModel.h"

@implementation ChatUserModel

+ (instancetype)initChatUserModelByDict:(NSDictionary *)dict{
    ChatUserModel *model = [[ChatUserModel alloc]init];
    model.userId = dict[@"userId"];
    model.pushToken = dict[@"token"];
    model.userName = dict[@"name"];
    model.photo = dict[@"url"];
    
    return model;
}

@end
