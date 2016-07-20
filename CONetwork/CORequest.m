//
//  CORequest.m
//  BusinessShow
//
//  Created by xuaofei on 16/6/13.
//
//

#import "CORequest.h"
#import "COPreResponseHandler.h"
#import "COPreRequestHandler.h"

@implementation CORequest

- (id)init {
    self = [super init];
    if (self) {
        self.method = COHttpMethodPost;
        self.responseFormat = [[self responseClass] responseDataFormat];
    }
    return self;
}


- (void)requestWithSuccessBlock:(void (^)(NSURLSessionTask *task,COResponse * responseData))success failure:(void (^)(NSURLSessionTask *task, NSError * error))failure
{
    [self validParameters];
    
    if (self.method == COHttpMethodGet || self.method == COHttpMethodPost)
    {
        //过滤请求，是否往下传递
        BOOL res = NO;
        [[COPreRequestHandler shared] preRequestHandler:self result:&res];
        if (res) {
            return;
        }
        
        __block CORequest *weakSelf = self;
        self.httpSuccessBlock = ^(NSURLSessionTask *task, id responseObject)
        {
            Class responseClass = [weakSelf responseClass];
            if (![responseClass isSubclassOfClass:[COResponse class]])
            {
                @throw [NSException exceptionWithName:@"类型错误" reason:@"responseClass必须为COResponse的子类" userInfo:nil];
                return;
            }
        
            
            COResponse * response = [[responseClass alloc] init];
            response.request = weakSelf;
            response.data = responseObject;
            
            
            ////过滤回应，是否往下传递
            BOOL res = NO;
            [[COPreResponseHandler shared] preResponseHandler:response result:&res];
            if (res) {
                return;
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success(task,response);
                }
            });
        };
        
        self.httpFailureBlock = ^(NSURLSessionTask *task, NSError *error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) {
                    failure(task,error);
                }
            });
        };
    }
    [self send];
}

- (void)uploadFileWithBlock:(void (^)(NSURLSessionTask *task,BOOL completed,long long bytes, long long totalBytes,NSError *error))block
{
    [self validParameters];
    __weak CORequest *weakSelf = self;
    if (self.method == COURLUploadFile)
    {
        self.uploadDataBlock = ^(NSURLSessionTask *task,BOOL completed,long long bytes, long long totalBytes,NSError *error,id responseObject)
        {
            Class responseClass = [weakSelf responseClass];
            if (![responseClass isSubclassOfClass:[COResponse class]])
            {
                @throw [NSException exceptionWithName:@"类型错误" reason:@"responseClass必须为COResponse的子类" userInfo:nil];
                return;
            }
            
            
            COResponse * response = [[responseClass alloc] init];
            response.data = responseObject;
            response.request = weakSelf;
            
            ////过滤回应，是否往下传递
            BOOL res = NO;
            [[COPreResponseHandler shared] preResponseHandler:response result:&res];
            if (res) {
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (block) {
                    block(task,completed,bytes,totalBytes,error);
                }
            });
        };
    }
    
    [self send];
}

//- (void)uploadFileWithBlock:(UploadDataBlock)block
//{
//    [self validParameters];
//    
//    if (self.method == COURLUploadFile)
//    {
//        self.uploadDataBlock = block;
//    }
//    
//    [self send];
//}

- (void)downloadFileWithBlock:(DownloadDataBlock)block
{
    [self validParameters];
    
    if (self.method == COURLDownloadFile)
    {
        self.downloadDataBlock = block;
    }
    
    [self send];
}

- (Class)responseClass
{
    @throw [NSException exceptionWithName:@"方法错误" reason:@"必须实现抽象方法" userInfo:nil];
}

- (void)validParameters
{

}

@end
