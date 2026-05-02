//
//  PFK_playWaringSound.h
//  PFK-IntelligentHome
//
//  Created by qiushi on 16/8/20.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface PFK_playWaringSound : NSObject

singleton_h(PFK_playWaringSound);


-(void)playSound;
-(void)stopSound;


@end
