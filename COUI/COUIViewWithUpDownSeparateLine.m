//
//  UIViewWithUpDownSeparateLine.m
//  pay
//
//  Created by xuaofei on 15/12/1.
//  Copyright © 2015年 yousai. All rights reserved.
//

#import "COUIViewWithUpDownSeparateLine.h"

@implementation COUIViewWithUpDownSeparateLine
{
    BOOL didSetup;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!didSetup) {
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 0.5f)];
        
        upLine.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        
        upLine.backgroundColor = [UIColor grayColor];
        
        [self addSubview:upLine];
        
        
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.frame.size.height - 0.5f, self.frame.size.width, 0.5f)];
        
        downLine.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        
        downLine.backgroundColor = [UIColor grayColor];
        
        [self addSubview:downLine];
    }
    didSetup = YES;
}

@end
