//
//  NetworkBase.m
//  RongYunDemo
//
//  Created by duanpeng on 17/4/13.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import "NetworkBase.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NetworkBase

+ (NSString *)md5:(NSString *)str
{
    //DONE:md5加密
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)getKey {
    NSDate *thisDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:thisDate];
    NSString *sign = [NSString stringWithFormat:@"ihkapp_web%@", strDate] ;
    return [self md5:sign];
}

+ (NSString *)getPushToken {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"pushToken"] != nil) {
        return [user objectForKey:@"pushToken"];
    }
    else {
        NSString *pushToken = [self getDeviceCode];
        [user setObject:pushToken forKey:@"pushToken"];
        [user synchronize];
        return pushToken;
    }
    return nil;
}

//https://appwebtest.ihk.cn/ihkapp_web/app/user/getUserToken.htm?userId=1978&appVersion=2.1.0&usersId=1978&portraitUri=http://img1.appweb.ihk.cn/gd/estate/scan_photo/2015-06-12/9af99ae2d6714900857c47c71ec3ae54(U-29554-2015-06-12)_compress&userPushToken=iosdevice-DFFC93DC-5009-4E56-BABE-7A8EF7486942&appType=IOS&name=梁永德&ukey=0e9051b4146daf77c0c1e69489f1ca9b
/* 生成机器号 */
+ (NSString *)getDeviceCode {
        NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return [NSString stringWithFormat:@"iosdevice%@", UUID];
}
+ (NSString *)getUserId {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user objectForKey:@"userId"] != nil) {
        return [user objectForKey:@"userId"];
    }
    return @"";
}

+ (void)getBLLStringData:(NSString *)serverUrl useParameters:(NSMutableDictionary *)paras success:(void (^)(NSDictionary *arrData))success fail:(void (^)(NSError *error))fail{
    
    [paras setValue:[self getKey] forKey:@"ukey"];
    [paras setValue:@"IOS" forKey:@"appType"];
    [paras setValue:@"2.1.0" forKey:@"appVersion"];
    [paras setValue:[self getPushToken] forKey:@"userPushToken"];
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
     [self printLog:serverUrl paras:paras];//输出
    
    [session GET:serverUrl parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}



+ (void)getRequestWithUrl:(NSString *)serverUrl
                    paras:(NSMutableDictionary *)paras
                  success:(void (^)(NSDictionary *model))success
                     fail:(void (^)(NSError *error))fail {
   
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self printLog:serverUrl paras:paras];
    [session POST:serverUrl parameters:paras constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [session GET:serverUrl parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}



+ (void)printLog:(NSString *)serverUrl paras:(NSMutableDictionary *)paras {
    NSString *url = @"";
    for (NSString *keyName in paras) {
        url = [[[[url stringByAppendingString:@"&"] stringByAppendingString:keyName]stringByAppendingString:@"="]stringByAppendingString:[NSString stringWithFormat:@"%@",[paras objectForKey:keyName]]];
    }
    url = [url substringFromIndex:1];
    url = [[serverUrl stringByAppendingString:@"?"]stringByAppendingString:url];
    NSLog(@"数据请求地址:\n%@",url);
}

@end
