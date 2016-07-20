//
//  UIImage+generateQRCode.h
//  COKit
//
//  Created by xuaofei on 16/7/16.
//  Copyright © 2016年 xuaofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (generateQRCode)
+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;
@end
