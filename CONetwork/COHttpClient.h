//
//  COHttpClient.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/12.
//
//

#import <Foundation/Foundation.h>
#import "COURLClient.h"
#import "CONetworkParameters.h"
#import "CONetwork.h"


typedef void(^SuccessBlock)(NSURLSessionTask *task, id responseObject);

typedef void(^FailureBlock)(NSURLSessionTask *task, NSError *error);




@interface COHttpClient : COURLClient
/*!
 *  成功block
 */
@property (nonatomic, copy) SuccessBlock httpSuccessBlock;

/*!
 *  失败block
 */
@property (nonatomic, copy) FailureBlock httpFailureBlock;



@property(retain, nonatomic, readonly) COMutableRequestParameters *httpSystemParameters;
/*!
 *  网络请求的参数
 */
@property(weak, nonatomic, readonly) COMutableRequestParameters *httpUserParameters;

/*!
 *  创建头部
 */
//- (void)buildHeaders:(COMutableParameters *)headers;

/*!
 *  网络请求的服务名称
 */
@property(nonatomic, strong) NSString *serviceName;


/*!
 *  网络请求的响应格式
 */
@property(nonatomic, assign) ResponseDataFormat responseFormat;



/*!
 *  是否需要验证用户信息
 *
 *  @return NO
 */
- (BOOL)needAuthUser;
/*!
 *  需要验证系统时间
 *
 *  @return NO
 */
- (BOOL)needTimestamp;

- (BOOL)setPlatform;

- (void)buildSystemParameters:(COMutableRequestParameters*)systemParameters;

- (void)buildUserParameters:(COMutableRequestParameters*)userParameters;

@end
