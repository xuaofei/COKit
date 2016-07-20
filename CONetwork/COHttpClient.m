//
//  COHttpClient.m
//  BusinessShow
//
//  Created by xuaofei on 16/6/12.
//
//

#import "COHttpClient.h"

@implementation COHttpClient{
    COMutableRequestParameters *_httpSystemParameters;
    COMutableRequestParameters *_httpUserParameters;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.responseFormat = ResponseDataFormatJson;
    }
    return self;
}

- (BOOL)needAuthUser
{
    return NO;
}

- (BOOL)needTimestamp
{
    return NO;
}

- (BOOL)setPlatform
{
    return NO;
}

- (COMutableRequestParameters *)httpSystemParameters
{
    if (!_httpSystemParameters) {
        _httpSystemParameters = [[COMutableRequestParameters alloc] init];
    }

    [self buildSystemParameters:_httpSystemParameters];

    return _httpSystemParameters;
}

- (COMutableRequestParameters *)httpUserParameters
{
    if (!_httpUserParameters) {
        _httpUserParameters = [[COMutableRequestParameters alloc] init];
    }
    
    [self buildUserParameters:_httpUserParameters];
    
    return _httpUserParameters;
}

- (void)buildSystemParameters:(COMutableRequestParameters*)systemParameters;
{
    /*!
     *  系统参数
     *  1:versionCode 内部开发版本号
     *  2:version 外部版本号
     */
    
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    [systemParameters addParameter:appVersion forKey:@"versionCode"];
    
    NSString *appShortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [systemParameters addParameter:appShortVersion forKey:@"version"];
    
    
    [systemParameters addParameter:@"ios" forKey:@"source"];
    UIDevice *device = [[UIDevice alloc] init];
    [systemParameters addParameter:device.model forKey:@"phoneModel"];
    [systemParameters addParameter:[NSString stringWithFormat:@"IOS%@",device.systemVersion] forKey:@"systemVersion"];
//    [systemParameters addParameter:[BusinessShowConfig shared].udid forKey:@"udid"];
}

- (void)buildUserParameters:(COMutableRequestParameters*)userParameters
{

}

- (void)send
{
//    if (self.method == COURLDownloadFile) {
//        [super send];
//        return;
//    }
    
    
    COMutableRequestParameters *parameters = [[COMutableRequestParameters alloc] init];
    [parameters addParameters:[self.httpSystemParameters dictionary]];
    [parameters addParameters:[self.httpUserParameters dictionary]];
    
    
    /*!
     *  添加时间参数
     */
    if ([self needTimestamp]) {
        NSNumber * requestTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"timeDifference"];
        NSDate * date = [NSDate date];
        
        double time = date.timeIntervalSince1970 - requestTime.doubleValue;
        
        NSString * timestamp = [[NSString alloc] initWithCString:[[NSString stringWithFormat:@"%.0f",time * 1000] UTF8String] encoding:NSUTF8StringEncoding];
        
        [parameters addParameter:timestamp forKey:@"timestamp"];
    }
    [parameters addParameter:[parameters signString] forKey:@"sign"];
    
    
    if (self.method == COHttpMethodGet || self.method == COHttpMethodPost)
    {
        if (self.manager) {
            [self.manager.operationQueue cancelAllOperations];
            self.manager = nil;
        }
        self.manager = [AFHTTPSessionManager manager];
        AFHTTPSessionManager *manager = (AFHTTPSessionManager*)self.manager;
        
        self.manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];

        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
        manager.requestSerializer.timeoutInterval = self.timeOut;
        
        if (self.responseFormat == ResponseDataFormatJson) {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
        }
        else if (self.responseFormat == ResponseDataFormatXml) {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        }
        else {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
        
        switch (self.method) {
            case COHttpMethodPost:
                [manager POST:self.serviceName parameters:[parameters dictionary] progress:nil success:self.httpSuccessBlock failure:self.httpFailureBlock];
                break;
            case COHttpMethodGet:
                [manager GET:self.serviceName parameters:[parameters dictionary] progress:nil success:self.httpSuccessBlock failure:self.httpFailureBlock];
                break;
            default:
                break;
        }
    }
    else if (self.method == COURLUploadFile)
    {//要加文件上传的张数
        [parameters addParameter:@(self.uploadFilePaths.count) forKey:@"fileCount"];
        
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:self.uploadURL parameters:[parameters dictionary] constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
        {
            NSInteger index = 0;
            for (NSString *filePath in self.uploadFilePaths)
            {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:[NSString stringWithFormat:@"FileData%03ld",(long)index] fileName:[NSString stringWithFormat:@"fileName%03ld.png",(long)index] mimeType:@"image/png" error:nil];
                index++;
            }

        } error:nil];
        
        
        __block int64_t totalUnitCount = 0;
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        __block NSURLSessionUploadTask *uploadTask = nil;
        uploadTask = [manager
                      uploadTaskWithStreamedRequest:request
                      progress:^(NSProgress * _Nonnull uploadProgress) {
                          
                          self.uploadDataBlock(uploadTask,NO,uploadProgress.completedUnitCount,uploadProgress.totalUnitCount,nil,nil);
                          totalUnitCount = uploadProgress.totalUnitCount;
                      }
                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                          if (error)
                          {
                              self.uploadDataBlock(uploadTask,NO,uploadTask.countOfBytesSent,totalUnitCount,error,responseObject);
                          }
                          else
                          {
                              self.uploadDataBlock(uploadTask,YES,uploadTask.countOfBytesSent,totalUnitCount,nil,responseObject);
                          }
                      }];
        
        [uploadTask resume];
    }
    else if (self.method == COURLDownloadFile)
    {
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:self.downloadURL parameters:[parameters dictionary] error:nil];
        
        [request addValue:@"User-Agent" forHTTPHeaderField:@"Accept-Encoding"];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        
        __block int64_t totalUnitCount = 0;
        __block NSURLSessionDownloadTask *downloadTask = nil;

        downloadTask = [manager
                        downloadTaskWithRequest:request
                        progress:^(NSProgress *downloadProgress){
                            self.downloadDataBlock(downloadTask,downloadProgress.completedUnitCount==downloadProgress.totalUnitCount?YES:NO,downloadProgress.completedUnitCount,downloadProgress.totalUnitCount,nil);
                            totalUnitCount = downloadProgress.totalUnitCount;
                        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                            
                            NSURL *documentsDirectoryURL = [[NSURL alloc] initFileURLWithPath:self.downloadFilePath];
                            
                            return documentsDirectoryURL;
                        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {

                            if (error) {
                                self.downloadDataBlock(downloadTask,NO,downloadTask.countOfBytesReceived,totalUnitCount,error);
                            }
                            else
                            {
                                self.downloadDataBlock(downloadTask,YES,downloadTask.countOfBytesReceived,totalUnitCount,nil);
                            }
                        }];
        [downloadTask resume];
    }
}
@end
