//
//  Networking.m
//  RongYunDemo
//
//  Created by duanpeng on 17/4/13.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import "Networking.h"



@implementation Networking






+ (void)getToken:(void (^)(NSDictionary *))success fail:(void (^)(NSError *))fail{
    NSMutableDictionary *paras = [[NSMutableDictionary alloc]init];
    [paras setObject:@"userId" forKey:@"18928795025"];
    [paras setObject:@"name" forKey:@"xiwen"];
    [paras setObject:@"portraitUri" forKey:@"http://pic.ihk.cn/first/287_h/ihk/2014/09/04/173347301.jpg"];
    
    [NetworkBase getRequestWithUrl:@"http://api.cn.ronghub.com/user/getToken.json" paras:paras success:^(NSDictionary *model) {
        if (success) {
            success(model);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)getRongYunToken:(NSString *)userId
               userName:(NSString *)userName
               photoUrl:(NSString *)photoUrl
                success:(void (^)(NSDictionary *strData))success
                   fail:(void (^)(NSError *error))fail {
    
    NSMutableDictionary *paras = [[NSMutableDictionary alloc]init];
    [paras setObject:(userId == nil ? @"" : userId) forKey:@"userId"];
    [paras setObject:(userName == nil ? @"" : userName) forKey:@"name"];
    [paras setObject:(photoUrl == nil ? @"" : photoUrl) forKey:@"portraitUri"];
    [paras setValue:userId forKey:@"usersId"];
    [NetworkBase getBLLStringData:@"https://appwebtest.ihk.cn/ihkapp_web/app/user/getUserToken.htm" useParameters:paras success:^(NSDictionary *strData) {
        if (success) {
            success(strData);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

@end

