//
//  ChatUserModel.h
//  RongYunDemo
//
//  Created by duanpeng on 17/4/20.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatUserModel : NSObject
@property (nonatomic, copy) NSString *userId;           /**< 用户Id */
@property (nonatomic, copy) NSString *pushToken;        /**< pushToken */
@property (nonatomic, copy) NSString *userName;         /**< 用户名 */
@property (nonatomic, copy) NSString *photo;            /**< 用户图片 */


+ (instancetype)initChatUserModelByDict:(NSDictionary *)dict;

@end
