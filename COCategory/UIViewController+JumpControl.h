//
//  UIViewController+j.h
//  COKit
//
//  Created by xuaofei on 16/7/3.
//  Copyright © 2016年 xuaofei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, JumpControlType) {
    JumpControlType_Push = 1 << 0,
    JumpControlType_Present = 1 << 1,
};

@interface UIViewController (JumpControl)
@property (copy, nonatomic) NSString *jumpControlBuoyID;

- (void)willVisibleFromViewController:(UIViewController*)viewController animated:(BOOL)animated jumpControlType:(JumpControlType)jumpControlType;

- (void)willInvisibleFromViewController:(UIViewController*)viewController animated:(BOOL)animated jumpControlType:(JumpControlType)jumpControlType;

- (void)backToSpecifyViewControllerWithJumpControlBuoyID:(NSString*)jumpControlBuoyID;

- (void)removeFromNavigationController;
@end
