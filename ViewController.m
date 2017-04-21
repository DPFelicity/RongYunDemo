//
//  ViewController.m
//  RongYunDemo
//
//  Created by duanpeng on 17/4/13.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import "ViewController.h"
#import "MyChatViewController.h"
#import "MyChatListViewController.h"
#import "DataTool+ChatUser.h"
#import "ChatUserModel.h"

@interface ViewController ()<RCIMUserInfoDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [DATATOOL clearChatUserWith:@"2011"];
    
}
- (void)addToData{
    [DATATOOL initChatUser];
    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"ChatUser" withExtension:@"plist"];
    NSArray *dataArray = [NSArray arrayWithContentsOfURL:plistUrl];
    for (NSDictionary *dict in dataArray) {
        ChatUserModel *model =  [ChatUserModel initChatUserModelByDict:dict];
        [DATATOOL insertWithChatUser:model];
    }
}

- (NSDictionary *)getUserInfoWith:(NSString *)userId{
    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"ChatUser" withExtension:@"plist"];
    NSArray *dataArray = [NSArray arrayWithContentsOfURL:plistUrl];
    for (NSDictionary *dict in dataArray) {
        if ([dict[@"userId"] isEqualToString:userId]) {
            return dict;
        }
    }
    return nil;
}

- (IBAction)goToChat:(id)sender {
    NSDictionary *dict = [self getUserInfoWith:self.textField.text];
    NSString *token = dict[@"token"];

    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        dispatch_async(dispatch_get_main_queue(),^{
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            
            
        //   [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:name portrait:url];//此方法第一次进来会话列表无头像
            
            MyChatListViewController *chat = [[MyChatListViewController alloc]init];
            [self.navigationController pushViewController:chat animated:YES];
        });
        
//        [[RCIM sharedRCIM] createDiscussion:@"讨论组" userIdList:@[@"1978",@"2000",@"2011"] success:^(RCDiscussion *discussion) {
//            
//            NSLog(@"讨论组ID:%@",discussion.discussionId);
////            讨论组ID:e894533e-4ebc-4742-b1c2-9714852a97b6
//            
//        } error:^(RCErrorCode status) {
//            
//        }];
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];

    
    
}

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion{
    NSDictionary *dict = [self getUserInfoWith:userId];
    NSString *name = dict[@"name"];
    NSString *url = dict[@"url"];
    RCUserInfo *userInfo = [[RCUserInfo alloc]init];
    userInfo.userId = userId;
    userInfo.name = name;
    userInfo.portraitUri = url;
    return completion(userInfo);
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
