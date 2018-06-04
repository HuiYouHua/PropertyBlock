# PropertyBlock
使用runtime回调的方式进行正向传值，适用于在两个界面过度中间进行相关逻辑的处理

- + (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method0 = class_getInstanceMethod(self.class, @selector(hy_presentViewController:animated:completion:));
        Method method1 = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        method_exchangeImplementations(method0, method1);
    });
}

- (void)hy_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    
    Property *property = [Property new];
    self.transitionBlock ? self.transitionBlock(property) : nil;
    
    NSMutableArray *propertyArray = [self hy_getPresentViewControllerProperty:viewControllerToPresent];
    NSArray *nameArray = propertyArray[0];
    NSArray *typeArray = propertyArray[1];
    
    for (int i = 0; i < nameArray.count; i++) {
        NSString *propertyName = nameArray[i];
        NSString *propertyType = typeArray[i];
        if ([@"_property" isEqualToString:propertyName]) {
            [viewControllerToPresent setValue:property forKey:propertyName];
        }
    }
    
    [self hy_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (NSMutableArray *)hy_getPresentViewControllerProperty:(UIViewController *)viewControllerToPresent {
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([viewControllerToPresent class], &outCount);
    
    
    // 遍历所有成员变量
    NSMutableArray *nameArray = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *typeArray = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < outCount; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *propertyType = [NSString stringWithUTF8String:type];
        
        [nameArray addObject:propertyName];
        [typeArray addObject:propertyType];
        NSLog(@"成员变量名：%s 成员变量类型：%s",name,type);
    }
    NSMutableArray *propertyArray = [NSMutableArray arrayWithObjects:nameArray, typeArray, nil];
    // 注意释放内存！
    free(ivars);
    return propertyArray;
}

- (void)hy_presentViewController:(UIViewController *_Nullable)viewControllerToPresent completion:(void (^ __nullable)(void))completion transitionBlock:(TransitionBlock _Nullable )transitionBlock {
    self.transitionBlock = transitionBlock ? transitionBlock : nil;
    [self presentViewController:viewControllerToPresent animated:YES completion:completion];
}

- (void)setTransitionBlock:(TransitionBlock)transitionBlock {
    objc_setAssociatedObject(self, &transitionBlockKey, transitionBlock, OBJC_ASSOCIATION_COPY);
}

- (TransitionBlock)transitionBlock {
    return objc_getAssociatedObject(self, &transitionBlockKey);
}
- 
