//
//  UIViewWithDownSeparateLine.m
//  pay
//
//  Created by xuaofei on 15/12/1.
//  Copyright © 2015年 yousai. All rights reserved.
//

#import "COUIViewWithDownSeparateLine.h"
#import <PureLayout.h>

@implementation COUIViewWithDownSeparateLine
{
    BOOL didSetup;
    UIView *downLine;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!downLine) {
        UIView *downLine = [[UIView alloc] init];
        
        downLine.backgroundColor = [UIColor grayColor];
        
        [self addSubview:downLine];
        
        [downLine autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [downLine autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [downLine autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [downLine autoSetDimension:ALDimensionHeight toSize:0.5f];
        
        didSetup = YES;
    }
}
@end
