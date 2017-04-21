//
//  NetworkBase.h
//  RongYunDemo
//
//  Created by duanpeng on 17/4/13.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkBase : NSObject

+ (void)getRequestWithUrl:(NSString *)serverUrl
                    paras:(NSMutableDictionary *)paras
                  success:(void (^)(NSDictionary *model))success
                     fail:(void (^)(NSError *error))fail;

+ (void)getBLLStringData:(NSString *)serverUrl useParameters:(NSMutableDictionary *)paras success:(void (^)(NSDictionary *arrData))success fail:(void (^)(NSError *error))fail;


@end
