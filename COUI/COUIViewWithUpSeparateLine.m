//
//  COUIViewWithUpSeparateLine.m
//  BusinessShow
//
//  Created by xuaofei on 16/6/21.
//
//

#import "COUIViewWithUpSeparateLine.h"

@implementation COUIViewWithUpSeparateLine
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
    }
    didSetup = YES;
}
@end
