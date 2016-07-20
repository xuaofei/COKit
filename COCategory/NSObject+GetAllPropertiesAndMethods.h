//
//  NSObject+GetAllPropertiesAndMethods.h
//  COKit
//
//  Created by xuaofei on 16/6/28.
//  Copyright © 2016年 xuaofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (GetAllPropertiesAndMethods)
- (NSArray *)getAllProperties;
- (void)LogAllMethods;
@end
