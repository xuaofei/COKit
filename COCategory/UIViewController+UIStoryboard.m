//
//  UIViewController+UIStoryboard.m
//  BusinessShow
//
//  Created by xuaofei on 16/6/17.
//
//

#import "UIViewController+UIStoryboard.h"

@implementation UIViewController (UIStoryboard)
+ (instancetype)viewControllerWithStoryboardName:(NSString*)storyboardName ViewControllerWithIdentifier:(NSString*)viewControllerWithIdentifier
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    
    NSAssert(mainStoryBoard, @"");
    
    //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
    UIViewController *viewController = [mainStoryBoard instantiateViewControllerWithIdentifier:viewControllerWithIdentifier];
    
    NSAssert(viewController, @"");
    
    return viewController;
}
@end
