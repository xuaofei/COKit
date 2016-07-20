//
//  COResponseFilter.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/14.
//
//

#import <Foundation/Foundation.h>
#import "COResponse.h"

@interface COPreResponseHandler : NSObject
+ (instancetype)shared;

- (void)preResponseHandler:(COResponse*)response result:(BOOL*)res;
@end