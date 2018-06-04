//
//  ViewController.m
//  PropertyBlock
//
//  Created by 华惠友 on 2018/6/4.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "UIViewController+Transition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SecondViewController *vc = [SecondViewController new];
    [self hy_presentViewController:vc completion:nil transitionBlock:^(Property * _Nullable property) {
        property.name = @"huayoyu";
        property.userId = 10086;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
