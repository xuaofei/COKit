//
//  COResponse.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/13.
//
//

//#import "COResponseDataHandler.h"
#import <Foundation/Foundation.h>
#import "CONetwork.h"

@class CORequest;

@interface COResponse : NSObject
+ (ResponseDataFormat)responseDataFormat;

- (void)parseData:(id)data;

@property (nonatomic,retain) CORequest *request;

/**
 *  原始数据
 */
@property(nonatomic, strong) id data;


/*!
 *  网络请求的响应格式
 */
@property(nonatomic, assign,readonly) ResponseDataFormat responseFormat;

/*!
 *  错误信息
 */
@property (nonatomic, strong) NSString *errorMsg;
/**
 *  错误状态码
 */
@property (nonatomic, strong) NSString* errorCode;

@property (nonatomic, assign) BOOL isError;
@end
