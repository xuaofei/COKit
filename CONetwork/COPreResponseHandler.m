//
//  COResponseFilter.m
//  BusinessShow
//
//  Created by xuaofei on 16/6/14.
//
//

#import "COPreResponseHandler.h"

@implementation COPreResponseHandler
+ (instancetype)shared
{
    static COPreResponseHandler *filter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        filter = [[COPreResponseHandler alloc] init];
    });
    
    return filter;
}

- (void)preResponseHandler:(COResponse*)response result:(BOOL*)res
{
    *res = NO;
}
@end
