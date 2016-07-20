//
//  CONetworkParameters.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/12.
//
//

#import <Foundation/Foundation.h>

@interface CORequestParameters : NSObject{
@protected
    NSMutableDictionary *_dictionary;
}
/*!
 *  获取参数集合的签名
 *
 *  @return [signString md5String]
 */
- (NSString *)signString;

/*!
 *  获取参数集合的字典
 *
 *  @return NSDictionary
 */
- (NSDictionary*)dictionary;

/*!
 *  参数总数
 *
 *  @return NSInteger
 */
- (NSInteger)count;

@end



/*!
 *  可变参数集合类
 */
@interface COMutableRequestParameters : CORequestParameters {
}
/*!
 *  新增一个参数
 *
 *  @param value value
 *  @param key   key
 */
- (void)addParameter:(id)value forKey:(NSString *)key;

- (void)addParameters:(NSDictionary*)dic;

/*!
 *  移除一个参数
 *
 *  @param key key
 */
- (void)removeParameter:(NSString *)key;

/*!
 *  清空参数集合
 */
- (void)clearAllParameter;

/*!
 *  获取一个参数
 *
 *  @param key key
 *
 *  @return value
 */
-(id)getParameter:(NSString *)key;

@end