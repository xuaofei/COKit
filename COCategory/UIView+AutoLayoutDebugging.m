

#import "UIView+AutoLayoutDebugging.h"

@implementation UIView (AutoLayoutDebugging)

- (void) checkAmbiguity
{
    if([self hasAmbiguousLayout]){
        NSLog(@"<%@:0x%0x>: %@",NSStringFromClass([self class]), (int)self,@"约束异常");
    }
    for (UIView *view in self.subviews)
        [view checkAmbiguity];
}
@end
