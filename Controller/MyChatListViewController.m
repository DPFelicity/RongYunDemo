//
//  MyChatListViewController.m
//  RongYunDemo
//
//  Created by duanpeng on 17/4/18.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import "MyChatListViewController.h"
#import "MyChatViewController.h"

@interface MyChatListViewController ()

@end

@implementation MyChatListViewController
- (id)init{
    self = [super init];
    if (self) {
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                            @(ConversationType_DISCUSSION),
                                            @(ConversationType_CHATROOM),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_APPSERVICE),
                                            @(ConversationType_SYSTEM)]];
        
        //设置需要将哪些类型的会话在会话列表中聚合显示
//        [self setCollectionConversationType:@[@(ConversationType_PRIVATE),
//                                              @(ConversationType_DISCUSSION),
//                                              @(ConversationType_GROUP)]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"会话列表";
    self.conversationListTableView.tableFooterView = [[UIView alloc]init];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshConversationTableViewIfNeeded];
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    //    聚合显示判断
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        MyChatListViewController *temp = [[MyChatListViewController alloc]init];
        NSArray *array = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationType]];
        [temp setDisplayConversationTypes:array];
        [temp setCollectionConversationType:nil];
        temp.isEnteredToCollectionViewController = YES;
        [self.navigationController pushViewController:temp animated:YES];
        
    }else{
//        设置对方头像
        NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"ChatUser" withExtension:@"plist"];
        NSArray *dataArray = [NSArray arrayWithContentsOfURL:plistUrl];
        NSString *name;
        NSString *url;
        NSString *token;
        for (NSDictionary *dict in dataArray) {
            if ([dict[@"userId"] isEqualToString:model.targetId]) {
                name = dict[@"name"];
                token = dict[@"token"];
                url = dict[@"url"];
            }
        }
        
       // [[RCIM sharedRCIM] refreshUserInfoCache:[[RCUserInfo alloc] initWithUserId:model.targetId name:name portrait:url] withUserId:model.targetId];
        
        MyChatViewController *conversationVC = [[MyChatViewController alloc]init];
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;
        
        conversationVC.title = name;
        [self.navigationController pushViewController:conversationVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
