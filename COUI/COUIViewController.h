//
//  COUIViewControllerWithBackButton.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/21.
//
//

#import <UIKit/UIKit.h>

@interface COUIViewController : UIViewController
//UINavigationController
- (void)willPushFromViewController:(UIViewController*)viewController animated:(BOOL)animated;

- (void)willAppearFromPopViewController:(UIViewController*)popViewController animated:(BOOL)animated;

//UIViewController
- (void)willPresentFromViewController:(UIViewController*)viewController animated:(BOOL)animated;

- (void)willAppearFromDismissViewController:(UIViewController*)dismissViewController animated:(BOOL)animated;



@property (copy, nonatomic) NSString *viewControllerBuoyID;
@end


@interface UIViewController (COUIViewController)
- (void)backToSpecifyViewControllerWithBuoyID:(NSString*)viewControllerBuoyID;
@end
