//
//  ELKGCDTimer.m
//  ELKGCDTimer
//
//  Created by wx on 2020/4/27.
//  Copyright © 2020 wx. All rights reserved.
//

#import "ELKGCDTimer.h"

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#endif

static const double kDefaultIntervalInSeconds = 1.0;


@interface ELKGCDTimer ()
/// 定时器
@property (nonatomic, strong) dispatch_source_t timer;
/// 定时器是否挂起
@property (nonatomic, assign) BOOL isSuspend;
/// 重复次数
@property (nonatomic, assign) NSInteger repeatCount;
/// 定时器指定间隔（单位：秒），默认为 1s
@property (nonatomic, assign) NSTimeInterval timerInterval;
/// 是否是无限次,如果是无限次,提醒用户手动销毁
@property (nonatomic, assign) BOOL isMaxTimes;

/// 定时器的回调
@property (nonatomic, copy) ELKGCDTimerBlock elk_easyTimerBlock;
@end


@implementation ELKGCDTimer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configInit];
        self.repeatCount = 0;
        self.isSuspend = YES;
    }
    return self;
}

- (void)configInit{
    
    _timerInterval = kDefaultIntervalInSeconds;
}

/// 开启一个定时器
/// @param ti       定时间隔时间,默认为1秒
/// @param rpCount  重复次数：0表示无限次
/// @param easyBock 步进时间
+ (ELKGCDTimer *)elk_easyTimeInterval:(NSTimeInterval)ti repeatCount:(NSInteger)rpCount block:(ELKGCDTimerBlock)easyBock
{
   
    ELKGCDTimer *GCDTimer = [[ELKGCDTimer alloc] init];
    GCDTimer.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
//    GCDTimer.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(GCDTimer.timer, DISPATCH_TIME_NOW, ti * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(GCDTimer.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [GCDTimer commentAnimation];
        });
    });
    GCDTimer.repeatCount = rpCount > 0 ? rpCount : MAXFLOAT;
    GCDTimer.isMaxTimes = rpCount == 0 ? YES : NO;
    GCDTimer.elk_easyTimerBlock = easyBock;
    GCDTimer.isSuspend = YES;
    [GCDTimer starTimer];
    return GCDTimer;
}

/// 启动定时器
- (void)starTimer
{
    if (self.timer&&self.isSuspend) {
        // 如果有计时器,就直接恢复到开始
        dispatch_resume(self.timer);
        self.isSuspend = NO;
    }
}

/// 暂定定时器
- (void)suspendTimer
{
    if (!self.isSuspend && self.timer) {
        dispatch_suspend(self.timer);
        self.isSuspend = YES;
    }
}
/// 释放定时器
- (void)killTimer
{
    if (self.timer) {
        if (self.isSuspend) {/// 如果挂起的话,先开启定时器,再去取消
            dispatch_resume(self.timer);
        }
         dispatch_source_cancel(self.timer);
         self.timer = nil;
        NSLog(@"GCD定时器已销毁/Timer has been destroyed");
     }
}
/// 定时器的事件
- (void)commentAnimation
{
    if (self.repeatCount <= 0) {
        [self killTimer];
    }else{
        self.repeatCount--;
        if (self.elk_easyTimerBlock) {
            self.elk_easyTimerBlock(self, self.repeatCount);
            if (self.isMaxTimes) {
                NSLog(@"当前定时器配置为无限次,请根据需求手动调用 - killTimer 方法销毁");
            }else{
                
                NSLog(@"ELKGCDTImer - repeatCount: %ld",self.repeatCount);
            }
        }
    }
}

@end
