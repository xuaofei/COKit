//
//  CORequest.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/13.
//
//

#import "COHttpClient.h"
#import "COResponse.h"

@interface CORequest : COHttpClient

- (void)requestWithSuccessBlock:(void (^)(NSURLSessionTask *task,COResponse * responseData))success failure:(void (^)(NSURLSessionTask *task, NSError * error))failure;

- (void)uploadFileWithBlock:(void (^)(NSURLSessionTask *task,BOOL completed,long long bytes, long long totalBytes,NSError *error))block;

- (void)downloadFileWithBlock:(DownloadDataBlock)block;

/*!
 *  网络请求的响应类
 */
- (Class)responseClass;

- (void)validParameters;


@property (nonatomic,retain) NSError *error;


@end
