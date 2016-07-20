//
//  COURLClient.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/13.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "CONetwork.h"

typedef void (^UploadDataBlock)(NSURLSessionTask *task,BOOL completed,long long bytes, long long totalBytes,NSError *error,id responseObject);
typedef void (^DownloadDataBlock)(NSURLSessionTask *task,BOOL completed,long long bytes, long long totalBytes,NSError *error);


@interface COURLClient : NSObject

@property (nonatomic, strong) AFURLSessionManager * manager;

/*!
 *  网络请求超时时间
 */
@property(nonatomic, assign) NSTimeInterval timeOut;
/*!
 *  网络请求的方法
 */
@property(nonatomic, assign) CONetworkMethod method;

/*!
 *  上传进度block
 */
@property (nonatomic, copy) UploadDataBlock uploadDataBlock;

@property (nonatomic, retain) NSString *uploadURL;

@property (nonatomic, retain) NSArray<NSString *> *uploadFilePaths;


@property (nonatomic, copy) DownloadDataBlock downloadDataBlock;

@property (nonatomic, retain) NSString *downloadURL;

@property (nonatomic, retain) NSString *downloadFilePath;


- (void)send;
@end
