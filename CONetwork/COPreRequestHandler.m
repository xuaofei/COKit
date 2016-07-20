//
//  COPreRequestHandler.m
//  BusinessShow
//
//  Created by xuaofei on 16/6/14.
//
//

#import "COPreRequestHandler.h"

@implementation COPreRequestHandler
+ (instancetype)shared
{
    static COPreRequestHandler* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[COPreRequestHandler alloc] init];
    });
    
    return shared;
}

- (void)preRequestHandler:(CORequest*)response result:(BOOL*)res
{
    *res = NO;
    
//    if ([response needAuthUser] && true) {
//        
//    }
}
@end
