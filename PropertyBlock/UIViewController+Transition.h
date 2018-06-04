//
//  UIViewController+Transition.h
//  PropertyBlock
//
//  Created by 华惠友 on 2018/6/4.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Property.h"

@interface UIViewController (Transition)

typedef void(^TransitionBlock)(Property * _Nonnull property);

@property (nonatomic, copy) TransitionBlock _Nonnull transitionBlock;


- (void)hy_presentViewController:(UIViewController *_Nullable)viewControllerToPresent completion:(void (^ __nullable)(void))completion transitionBlock:(TransitionBlock _Nullable )transitionBlock ;
@end
