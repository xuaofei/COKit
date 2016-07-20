//
//  COProgressHUD.h
//  COKit
//
//  Created by xuaofei on 16/6/22.
//  Copyright © 2016年 xuaofei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface COProgressHUD : NSObject
+ (void)showLoad:(NSString*)message;
+ (void)showLoadWithoutInteractive:(NSString*)message;

+ (void)showTip:(NSString*)message;
+ (void)showTipWithoutInteractive:(NSString*)message;

+ (void)dismiss;
@end