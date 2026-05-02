//
//  PFK_NotificationTools.m
//  PFK-IntelligentHome
//
//  Created by qiushi on 16/8/27.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import "PFK_NotificationTools.h"
#import <UserNotifications/UserNotifications.h>
#import "XMGAudioTool.h"
//#import "QJCheckVersionUpdate.h"
@implementation PFK_NotificationTools


+(void)pushNotificationNotCamera:(NSString *)alter{
    [XMGAudioTool playSoundWithSoundName:@"hyzxPush.caf"];
    [self NSNotifitionIOS7:alter];
   
}


+(void)pushNotification:(NSString *)alter{
    
    [XMGAudioTool playSoundWithSoundName:@"hyzxPush.caf"];
    

        [self NSNotifitionIOS7:alter];
}
//IOS10通知

+(void)NSNotifitionIOS10:(NSString *)alter{
    
//第二步：新建通知内容对象
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"报警通知";
    content.subtitle = [NSString stringWithFormat:@"报警消息:%@",alter];
    content.body = @"";
    content.badge = @1;
    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"music.mp3"];
    content.sound = sound;

//第三步：通知触发机制。（重复提醒，时间间隔要大于60s）
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];

//第四步：创建UNNotificationRequest通知请求对象
    NSString *requertIdentifier = @"RequestIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];

//第五步：将通知加到通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"Error:%@",error);
    
}];
    
    
}
+(void)NSNotifitionIOS7:(NSString *)alter{
       UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        if (localNotification == nil) {
            return;
        }
        //设置本地通知的触发时间（如果要立即触发，无需设置），这里设置为20妙后
    //    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:20];
        //设置本地通知的时区
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        //设置通知的内容
        localNotification.alertBody = alter;
        //设置通知动作按钮的标题
        localNotification.alertAction = @"查看";
        //设置提醒的声音，可以自己添加声音文件，这里设置为默认提示声
        localNotification.soundName = @"hyzxPush.caf";
        //设置通知的相关信息，这个很重要，可以添加一些标记性内容，方便以后区分和获取通知的信息
    //    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:LOCAL_NOTIFY_SCHEDULE_ID,@"id",[NSNumber numberWithInteger:time],@"time",[NSNumber numberWithInt:affair.aid],@"affair.aid", nil];
    //    localNotification.userInfo = infoDic;
    
        //立即触发一个通知
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];

}

@end
