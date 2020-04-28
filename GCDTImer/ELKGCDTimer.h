//
//  ELKGCDTimer.h
//  ELKGCDTimer
//
//  Created by wx on 2020/4/27.
//  Copyright © 2020 wx. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN
@class ELKGCDTimer;

typedef void(^ELKGCDTimerBlock)(ELKGCDTimer *timer, NSInteger releaseCount);


@interface ELKGCDTimer : NSObject

/// 开启一个定时器
/// @param ti       定时间隔时间,默认为1秒
/// @param rpCount  重复次数：0表示无限次
/// @param easyBock 步进时间
+ (ELKGCDTimer *)elk_easyTimeInterval:(NSTimeInterval)ti repeatCount:(NSInteger)rpCount block:(ELKGCDTimerBlock)easyBock;
/// 启动定时器
- (void)starTimer;
/// 暂定定时器
- (void)suspendTimer;
/// 释放定时器
- (void)killTimer;
@end

NS_ASSUME_NONNULL_END
