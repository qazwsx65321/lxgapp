//
//  PFK_playWaringSound.m
//  PFK-IntelligentHome
//
//  Created by qiushi on 16/8/20.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import "PFK_playWaringSound.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
@interface PFK_playWaringSound()

@property (nonatomic,strong)AVAudioPlayer* pl;



@end



@implementation PFK_playWaringSound



singleton_m(PFK_playWaringSound);



-(AVAudioPlayer *)pl{
    
    if (!_pl) {
        NSURL *url = [[NSBundle mainBundle]URLForResource:[@"hyzxPush"stringByAppendingString:@".caf"] withExtension:Nil];
    
        _pl = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    }
    return _pl;
}

-(void)playSound{
    
    [self stopSound];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    [self.pl play];
    
    
}

-(void)stopSound{
    
    [self.pl stop];
    self.pl = nil;
    
}


@end
