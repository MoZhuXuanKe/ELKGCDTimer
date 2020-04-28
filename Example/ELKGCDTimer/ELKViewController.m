//
//  ELKViewController.m
//  ELKGCDTimer
//
//  Created by MoZhuXuanKe on 04/28/2020.
//  Copyright (c) 2020 MoZhuXuanKe. All rights reserved.
//

#import "ELKViewController.h"
#import <ELKGCDTimer/ELKGCDTimer-umbrella.h>


@interface ELKViewController ()
@property (nonatomic, strong) ELKGCDTimer * timer;
@property (nonatomic, strong) UILabel * numLabel;

@end

@implementation ELKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.numLabel];
    __weak typeof(self) weakSelf = self;
    self.timer = [ELKGCDTimer elk_easyTimeInterval:1 repeatCount:0 block:^(ELKGCDTimer * _Nonnull timer, NSInteger releaseCount) {
        weakSelf.numLabel.text = [NSString stringWithFormat:@"%ld",releaseCount];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UILabel *)numLabel
{
    return _numLabel ?: ({
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
        _numLabel.center = self.view.center;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.textColor = [UIColor blackColor];
        _numLabel;
    });
}
@end
