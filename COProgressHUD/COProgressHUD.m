//
//  COProgressHUD.m
//  COKit
//
//  Created by xuaofei on 16/6/22.
//  Copyright © 2016年 xuaofei. All rights reserved.
//

#import "COProgressHUD.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@implementation COProgressHUD
+ (void)generalSettings
{
    //设置背景色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    
    [SVProgressHUD setBackgroundColor:rgba(.0f, .0f, .0f, .7f)];

    //文字颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    //字体大小
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14.0f]];
    
    //设置线宽
    [SVProgressHUD setRingThickness:2.5f];
    
    //边角
    [SVProgressHUD setCornerRadius:4.0f];
}

+ (void)showLoad:(NSString*)message
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
    [self generalSettings];
    
    [SVProgressHUD resetOffsetFromCenter];
    
    [SVProgressHUD showWithStatus:message];
}

+ (void)showLoadWithoutInteractive:(NSString*)message
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    [self generalSettings];
    
    [SVProgressHUD resetOffsetFromCenter];
    
    [SVProgressHUD showWithStatus:message];

}

+ (void)showTip:(NSString*)message
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];

    [self generalSettings];
    
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, [UIScreen mainScreen].bounds.size.height/2 - 60)];
    
    [SVProgressHUD showImage:nil status:message];
}

+ (void)showTipWithoutInteractive:(NSString*)message
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    [self generalSettings];
    
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, [UIScreen mainScreen].bounds.size.height/2 - 55)];
    
    [SVProgressHUD showImage:nil status:message];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}
@end
