//
//  COPreRequestHandler.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/14.
//
//

#import <Foundation/Foundation.h>
#import "CORequest.h"

@interface COPreRequestHandler : NSObject
+ (instancetype)shared;

- (void)preRequestHandler:(CORequest*)response result:(BOOL*)res;
@end
