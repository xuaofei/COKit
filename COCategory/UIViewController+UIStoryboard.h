//
//  UIViewController+UIStoryboard.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/17.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (UIStoryboard)
+ (instancetype)viewControllerWithStoryboardName:(NSString*)storyboardName ViewControllerWithIdentifier:(NSString*)viewControllerWithIdentifier;
@end
