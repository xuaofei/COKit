//
//  UIImage+PureColor.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/21.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage(PureColor)
+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage*)scaleToSize:(CGSize)size;
@end
