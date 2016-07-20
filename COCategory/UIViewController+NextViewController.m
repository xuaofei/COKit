//
//  UIViewController+TraverseViewController.m
//  COKit
//
//  Created by xuaofei on 16/6/30.
//  Copyright © 2016年 xuaofei. All rights reserved.
//

#import "UIViewController+NextViewController.h"


@implementation UIViewController (NextViewController)

- (UIViewController*)nextViewController
{
    if (self.parentViewController) {
        NSLog(@"ParentViewController:%@",[self.parentViewController class]);
    }
    
    if (self.navigationController) {
        NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
        if (index > 0) {
            return [self.navigationController.viewControllers objectAtIndex:index - 1];
        }
        else {
            return [self.navigationController nextViewController];
        }
    }
    else if (self.tabBarController) {
        NSUInteger index = [self.tabBarController.viewControllers indexOfObject:self];
        if (index > 0) {
            return [self.tabBarController.viewControllers objectAtIndex:index - 1];
        }
        else {
            return [self.tabBarController nextViewController];
        }
    }
    else if (self.presentingViewController) {
        if ([self.presentingViewController isKindOfClass:[UINavigationController class]] || [self.presentingViewController isKindOfClass:[UITabBarController class]]) {
            return [self.presentingViewController.childViewControllers lastObject];
        }
        
        return self.presentingViewController;
    }
    
    return nil;
}

- (UIViewController*)nextPresentingViewController
{
    if (self.presentingViewController) {
        return self.presentingViewController;
    }
    else if (self.navigationController)
    {
        return [self.navigationController nextPresentingViewController];
    }
    else if (self.tabBarController)
    {
        return [self.tabBarController nextPresentingViewController];
    }
    
    return nil;
}
@end
