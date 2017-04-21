//
//  MyChatViewController.m
//  RongYunDemo
//
//  Created by duanpeng on 17/4/14.
//  Copyright © 2017年 duanpeng. All rights reserved.
//

#import "MyChatViewController.h"

@interface MyChatViewController ()<RCMessageCellDelegate>

@end

@implementation MyChatViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
/*!
 点击Cell中URL的回调
 
 @param url   点击的URL
 @param model 消息Cell的数据模型
 
 @discussion 点击Cell中的URL，会调用此回调，不会再触发didTapMessageCell:。
 */
- (void)didTapUrlInMessageCell:(NSString *)url model:(RCMessageModel *)model{
    NSLog(@"点击Cell中URL的回调 %@",url);
}

/*!
 点击Cell中电话号码的回调
 
 @param phoneNumber 点击的电话号码
 @param model       消息Cell的数据模型
 
 @discussion 点击Cell中的电话号码，会调用此回调，不会再触发didTapMessageCell:。
 */
- (void)didTapPhoneNumberInMessageCell:(NSString *) phoneNumber model:(RCMessageModel *)model{
    NSLog(@"电话号码%@",phoneNumber);
}

/*!
 点击Cell中用户头像的回调
 
 @param userId 头像对应的用户ID
 */
- (void)didTapCellPortrait:(NSString *)userId{
    NSLog(@"点击Cell中用户头像 %@",userId);
}

/*!
 长按Cell中用户头像的回调
 
 @param userId 头像对应的用户ID
 */
- (void)didLongPressCellPortrait:(NSString *)userId;
{
    NSLog(@"长按Cell中用户头像 %@",userId);
}

/*!
 长按Cell内容的回调
 
 @param model 消息Cell的数据模型
 @param view  长按区域的View
 */
- (void)didLongTouchMessageCell:(RCMessageModel *)model inView:(UIView *)view{
    NSLog(@"长按Cell内容的回调 %@",model);
}

#pragma mark - 修改cell样式
- (void)willDisplayConversationTableCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    RCMessageModel *model = cell.model;
    cell.delegate = self;
    if ([model.userInfo.userId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
        if ([cell isKindOfClass:[RCTextMessageCell class]]) {
            RCTextMessageCell *textCell = (RCTextMessageCell *)cell;
            textCell.textLabel.textColor = [UIColor orangeColor];
        } else if ([cell isKindOfClass:[RCImageMessageCell class]]) {
            RCImageMessageCell *messageCell = (RCImageMessageCell *)cell;
            for (UIView *view in messageCell.messageContentView.subviews) {
                [view setBackgroundColor:[UIColor redColor]];
            }
        }  else if ([cell isKindOfClass:[RCVoiceMessageCell class]]) {
            RCVoiceMessageCell *voiceCell = (RCVoiceMessageCell *)cell;
            voiceCell.voiceDurationLabel.textColor = [UIColor whiteColor];
        }
    } else {
        if ([cell isKindOfClass:[RCTextMessageCell class]]) {
            RCTextMessageCell *textCell = (RCTextMessageCell *)cell;
            textCell.textLabel.textColor = [UIColor grayColor];
        }
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
