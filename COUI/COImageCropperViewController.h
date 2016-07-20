//
//  VPImageCropperViewController.h
//  VPolor
//
//  Created by Vinson.D.Warm on 12/30/13.
//  Copyright (c) 2013 Huang Vinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COUIViewController.h"

@class COImageCropperViewController;

@protocol COImageCropperDelegate <NSObject>

- (void)imageCropper:(COImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage;
- (void)imageCropperDidCancel:(COImageCropperViewController *)cropperViewController;

@end

@interface COImageCropperViewController : COUIViewController

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) id<COImageCropperDelegate> delegate;
@property (nonatomic, assign) CGRect cropFrame;

- (id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame limitScaleRatio:(NSInteger)limitRatio;

@end
