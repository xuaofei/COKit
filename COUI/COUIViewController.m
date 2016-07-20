//
//  COUIViewControllerWithBackButton.m
//  BusinessShow
//
//  Created by xuaofei on 16/6/21.
//
//

#import "COUIViewController.h"
#import "UIViewController+NextViewController.h"

@implementation COUIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //    NSBundle *costomBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"COUIViewControllerWithBackButton1" ofType:@"bundle"]];
    //
    //
    //    NSBundle *bundle = [NSBundle bundleForClass:[COUIViewControllerWithBackButton class]];
    //
    ////    NSString * = [NSBundle b]
    //
    //    [NSBundle pathForResource:@"COUIViewControllerWithBackButton" ofType:@"bundle" inDirectory:nil];
    //    NSURL *url = [bundle URLForResource:@"COUIViewControllerWithBackButton" withExtension:@"bundle"];
    //    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    //
    //    NSString *path = [imageBundle pathForResource:@"anglebtn_backmask" ofType:@"png"];
    
    UIImage *image = [UIImage imageNamed:@"btn_back"];
//    UIImage *image = [UIImage imageNamed:@"COUIViewControllerWithBackButton.bundle/btn_back"];
    
    UIButton *btn_back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    [btn_back setImage:image forState:UIControlStateNormal];
    [btn_back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_back];
}

- (void)dealloc
{
    NSLog(@"%@:dealloc",[self class]);
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    if ([self.presentingViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *)self.presentingViewController;
        UIViewController *viewController = navigationController.topViewController;
        
        if ([viewController isKindOfClass:[COUIViewController class]]) {
            [((COUIViewController*)viewController) willAppearFromDismissViewController:self animated:flag];
        }
    }
    else if ([self.presentingViewController isKindOfClass:[UITabBarController class]])
    {
        
    }
    else
    {
        if ([self.presentingViewController isKindOfClass:[COUIViewController class]]) {
            [((COUIViewController*)self.presentingViewController) willAppearFromDismissViewController:self animated:flag];
        }
    }
    
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)willPushFromViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    
}

- (void)willAppearFromPopViewController:(UIViewController*)popViewController animated:(BOOL)animated
{
    
}

- (void)willPresentFromViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    
}

- (void)willAppearFromDismissViewController:(UIViewController*)dismissViewController animated:(BOOL)animated
{
    
}


- (void)backAction
{
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end




@implementation UIViewController (COUIViewController)
- (void)backToSpecifyViewControllerWithBuoyID:(NSString*)viewControllerBuoyID
{
    COUIViewController *specifyViewController = [self coViewControllerWithBuoyID:viewControllerBuoyID];
    
    if (self.presentingViewController) {
        if (![self.presentingViewController isEqual:specifyViewController]) {
            [specifyViewController willAppearFromDismissViewController:self animated:YES];
        }
    }
    else if (self.navigationController) {
        if (![self.navigationController isEqual:specifyViewController.navigationController]) {
            [specifyViewController willAppearFromPopViewController:self animated:YES];
        }
    }
    
    if (specifyViewController) {
        [self backToViewController:specifyViewController];
    }
}

- (void)backToViewController:(UIViewController*)toViewController
{
    if (toViewController.navigationController) {
        [toViewController.navigationController popToViewController:toViewController animated:YES];
        
        UIViewController *viewController = toViewController.navigationController;
        while (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
        }
        
        [self dissmissViewControllersFrom:viewController toViewController:toViewController.navigationController];
        
        
    }
    else if (toViewController.tabBarController)
    {
        UIViewController *viewController = toViewController;
        while (viewController.tabBarController) {
            viewController = viewController.tabBarController;
        }
        
        if (viewController.navigationController) {
            [viewController.navigationController popToViewController:viewController animated:YES];
        }
        else {
            UIViewController *viewController1 = viewController;
            while (viewController1.presentedViewController) {
                viewController1 = viewController1.presentedViewController;
            }
            
            [self dissmissViewControllersFrom:viewController1 toViewController:viewController];
        }
    }
    else
    {
        UIViewController *viewController = toViewController;
        while (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
        }
        
        [self dissmissViewControllersFrom:viewController toViewController:toViewController];
    }
}

- (void)dissmissViewControllersFrom:(UIViewController*)fromViewContrller toViewController:(UIViewController*)toViewController
{
    NSLog(@"start");
    UIImage *screenshotImage = nil;
//    if (toViewController.navigationController) {
//        screenshotImage = [self screenshotOfViewController:toViewController.navigationController];
//    }
//    else if (toViewController.tabBarController) {
//        screenshotImage = [self screenshotOfViewController:toViewController.tabBarController];
//    }
//    else {
//        screenshotImage = [self screenshotOfViewController:toViewController];
//    }
    screenshotImage = [self screenshotOfViewController:toViewController];
    UIImageView *screenshotImageView = [[UIImageView alloc] initWithImage:screenshotImage];
    
    [fromViewContrller.presentingViewController.view addSubview:screenshotImageView];
    __block UIViewController *nextViewContrller = fromViewContrller.presentingViewController;
    [fromViewContrller dismissViewControllerAnimated:YES completion:^{
        
        UIImageView *screenshotImageViewOnWindow = [[UIImageView alloc] initWithImage:screenshotImage];
        [[UIApplication sharedApplication].keyWindow addSubview:screenshotImageViewOnWindow];
        [screenshotImageView removeFromSuperview];
        
        [self dissmissViewControllersFrom:nextViewContrller toViewController:toViewController completion:^{
            [screenshotImageViewOnWindow removeFromSuperview];
        }];
    }];
}

- (void)dissmissViewControllersFrom:(UIViewController*)fromViewContrller toViewController:(UIViewController*)toViewController completion:(void (^)(void))completion
{
    if ([fromViewContrller isEqual:toViewController]) {
        NSLog(@"end");
        completion();
        return;
    }
    
    UIViewController *nextViewContrller = fromViewContrller.presentingViewController;
    
    [fromViewContrller dismissViewControllerAnimated:NO completion:^{
        
    [self dissmissViewControllersFrom:nextViewContrller toViewController:toViewController completion:completion];
    }];
}

- (UIImage*)screenshotOfViewController:(UIViewController*)viewController
{
    UIGraphicsBeginImageContextWithOptions(viewController.view.bounds.size, NO, 0);
    
    [viewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return screenshot;
}


-(COUIViewController*)nextCOViewController
{
    UIViewController *viewController = [self nextViewController];
    while (viewController)
    {
        if ([viewController isKindOfClass:[COUIViewController class]]) {
            return viewController;
        }
        else {
            viewController = [viewController nextViewController];
        }
    }
    return nil;
}

-(COUIViewController*)coViewControllerWithBuoyID:(NSString*)coViewControllerWithBuoyID
{
    COUIViewController *coViewController = [self nextCOViewController];
    while (coViewController) {
        if ([coViewController.viewControllerBuoyID isEqualToString:coViewControllerWithBuoyID]) {
            return coViewController;
        }
        else {
            coViewController = [coViewController nextCOViewController];
        }
    }
    
    return nil;
}
@end
