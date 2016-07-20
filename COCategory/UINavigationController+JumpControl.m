//
//  UINavigationController+JumpControl.m
//  COKit
//
//  Created by xuaofei on 16/6/29.
//  Copyright © 2016年 xuaofei. All rights reserved.
//

#import "UINavigationController+JumpControl.h"
#import <objc/message.h>

@implementation UINavigationController (JumpControl)
+ (void)load
{
    // Inject "-pushViewController:animated:"
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        do {
            Class class = [self class];
            
            SEL originalSelector = @selector(pushViewController:animated:);
            SEL swizzledSelector = @selector(jc_pushViewController:animated:);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            if (success) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        } while (NO);
        
        
        do {
            Class class = [self class];
            
            SEL originalSelector = @selector(popViewControllerAnimated:);
            SEL swizzledSelector = @selector(jc_popViewControllerAnimated:);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            if (success) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        } while (NO);
        
        do {
            Class class = [self class];
            
            SEL originalSelector = @selector(popToViewController:animated:);
            SEL swizzledSelector = @selector(jc_popToViewController:animated:);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            if (success) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        } while (NO);
    });
}

- (void)jc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController respondsToSelector:@selector(willPushFromViewController:animated:)])
    {
        ((void (*)(id, SEL, UIViewController *,BOOL))objc_msgSend)((id)viewController, @selector(willPushFromViewController:animated:), self.topViewController,animated);
    }
    [self jc_pushViewController:viewController animated:animated];
}


- (nullable UIViewController *)jc_popViewControllerAnimated:(BOOL)animated
{
    UIViewController *willPopViewController = self.topViewController;
    UIViewController *willPresentViewController = nil;
    if (self.viewControllers.count >= 2) {
        willPresentViewController = [self.viewControllers objectAtIndex:self.viewControllers.count - 2];
    }
    
    if ([willPresentViewController respondsToSelector:@selector(willAppearFromPopViewController:animated:)])
    {
        ((void (*)(id, SEL, UIViewController *,BOOL))objc_msgSend)((id)willPresentViewController, @selector(willAppearFromPopViewController:animated:),willPopViewController ,animated);
    }
    return [self jc_popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)jc_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (![viewController isEqual:self]) {
        UIViewController *willPopViewController = self.topViewController;
        if ([self.viewControllers containsObject:viewController]) {
            if ([viewController respondsToSelector:@selector(willAppearFromPopViewController:animated:)])
            {
                ((void (*)(id, SEL, UIViewController *,BOOL))objc_msgSend)((id)viewController, @selector(willAppearFromPopViewController:animated:),willPopViewController ,animated);
            }
        }
    }
    
    return [self jc_popToViewController:viewController animated:animated];
}
@end