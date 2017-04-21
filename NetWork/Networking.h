//
//  Networking.h
//  RongYunDemo
//
//  Created by duanpeng on 17/4/13.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkBase.h"

@interface Networking : NSObject



+ (void)getRongYunToken:(NSString *)userId
               userName:(NSString *)userName
               photoUrl:(NSString *)photoUrl
                success:(void (^)(NSDictionary *strData))success
                   fail:(void (^)(NSError *error))fail;

@end
