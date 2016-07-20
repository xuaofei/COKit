//
//  COURLClient.m
//  BusinessShow
//
//  Created by xuaofei on 16/6/13.
//
//

#import "COURLClient.h"

@implementation COURLClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeOut = 10.0f;
    }
    return self;
}

- (void)send
{
    if (_manager) {
        [_manager.operationQueue cancelAllOperations];
        _manager = nil;
    }
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = self.timeOut;
    _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    __block int64_t totalUnitCount = 0;
    switch (self.method) {
        case COURLDownloadFile:
        {
            NSURL *URL = [NSURL URLWithString:self.downloadURL];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            
            NSURLSessionDownloadTask *downloadTask = [_manager downloadTaskWithRequest:request
            progress:^(NSProgress *downloadProgress){
                self.downloadDataBlock(downloadTask,downloadProgress.completedUnitCount==downloadProgress.totalUnitCount?YES:NO,downloadProgress.completedUnitCount,downloadProgress.totalUnitCount,nil);
                totalUnitCount = downloadProgress.totalUnitCount;
            } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                NSURL *documentsDirectoryURL = [NSURL URLWithString:self.downloadFilePath];
                return documentsDirectoryURL;
            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                NSLog(@"File downloaded to: %@", filePath);
                
                if (error) {
                    self.downloadDataBlock(downloadTask,NO,downloadTask.countOfBytesReceived,totalUnitCount,error);
                }
                else{
                    self.downloadDataBlock(downloadTask,YES,downloadTask.countOfBytesReceived,totalUnitCount,nil);
                }
            }];
            [downloadTask resume];
        }
            break;
        case COURLUploadFile:
        {
//            return;
//            BOOL isDirectory = YES;
//            BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:self.uploadFilePath isDirectory:&isDirectory];
//            
//            if (!isExist || isDirectory) {
//                if (self.downloadDataBlock){
//                    NSString *domain = @"";
//                    NSString *desc = @"本地路径不正确";
//                    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
//                    
//                    NSError *error = [NSError errorWithDomain:domain
//                                                         code:0
//                                                     userInfo:userInfo];
//                    
//                    self.uploadDataBlock(nil,NO,0,0,error);
//                }
//            }
//            
//            NSURL *URL = [NSURL URLWithString:self.uploadURL];
//            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//            
//            NSURL *filePath = [NSURL fileURLWithPath:self.uploadFilePath];
//            NSURLSessionUploadTask *uploadTask = [_manager uploadTaskWithRequest:request fromFile:filePath progress:^(NSProgress *uploadProgress){
//                self.uploadDataBlock(uploadTask,uploadProgress.completedUnitCount==uploadProgress.totalUnitCount?YES:NO,uploadProgress.completedUnitCount,uploadProgress.totalUnitCount,nil);
//                totalUnitCount = uploadProgress.totalUnitCount;
//            }completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//                if (error) {
//                    self.uploadDataBlock(uploadTask,NO,uploadTask.countOfBytesSent,totalUnitCount,error);
//                }
//                else{
//                    self.uploadDataBlock(uploadTask,YES,uploadTask.countOfBytesSent,totalUnitCount,nil);
//                }
//            }];
//            [uploadTask resume];
        }
        default:
            break;
    }
}
@end
