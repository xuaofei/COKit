//
//  CONetworkParameters.m
//  BusinessShow
//
//  Created by xuaofei on 16/6/12.
//
//

#import "CONetworkParameters.h"
#import "NSString+Encryption.h"

@implementation CORequestParameters
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}


- (NSString *)signString {
    if ([self count] == 0) return @"";
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *sortedKeys = [[_dictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
    NSMutableString *signString = [NSMutableString stringWithString:@""];
    for (NSString *key in sortedKeys) {
        id value = [_dictionary objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [signString appendString:key];
            [signString appendString:value];
        }else if ([value isKindOfClass:[NSArray class]]) {
            for (id subValue in value) {
                if ([subValue isKindOfClass:[NSString class]]) {
                    [signString appendString:key];
                    [signString appendString:subValue];
                }else {
                    //异常数据类型
                    @throw [NSException exceptionWithName:@"签名参数类型错误" reason:@"签名参数类型只能是字符串或数组！" userInfo:nil];
                }
            }
        }else {
            //异常数据类型
            @throw [NSException exceptionWithName:@"签名参数类型错误" reason:@"签名参数类型只能是字符串或数组！" userInfo:nil];
        }
    }
    return [signString md5String];
}

- (NSDictionary*)dictionary {
    return _dictionary;
}

- (NSInteger)count {
    return [_dictionary count];
}

@end




@implementation COMutableRequestParameters

- (void)addParameter:(id)value forKey:(NSString *)key {
    if (!key) {
        @throw [NSException exceptionWithName:@"Error" reason:@"key for addParameter:forKey: is nil" userInfo:nil];
    }
    if (!value) {
        return;
    }

    [_dictionary setObject:value forKey:key];
}

- (void)addParameters:(NSDictionary*)dic
{
    [_dictionary addEntriesFromDictionary:dic];
}

-(id)getParameter:(NSString *)key{
    if (!key) {
        @throw [NSException exceptionWithName:@"Error" reason:@"key for removeParameter: is nil" userInfo:nil];
    }
    
    return [_dictionary objectForKey:key];
    
}

- (void)removeParameter:(NSString *)key {
    if (!key) {
        @throw [NSException exceptionWithName:@"Error" reason:@"key for removeParameter: is nil" userInfo:nil];
    }
    [_dictionary removeObjectForKey:key];
}

- (void)clearAllParameter {
    [_dictionary removeAllObjects];
}

@end
