//
//  COResponseDataHandler.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/13.
//
//

#import <Foundation/Foundation.h>
#import "COResponseData.h"
#import "CONetwork.h"

@interface COResponseDataHandler : NSObject
{
@private
    /*!
     *  网络应答的数据格式
     */
    ResponseDataFormat _responseFormat;
    /*!
     *  网络应答数据类
     */
    COResponseData *_responseData;
@protected
    NSError *_error;
    BOOL _isError;
}


- (void)parseData:(id)data format:(ResponseDataFormat)format;

/*!
 *  数据是否错误
 */
@property(nonatomic, readonly) BOOL isError;
/*!
 *  错误信息
 */
@property(nonatomic, readonly) NSError *error;
/*!
 *  数据的格式
 */
@property(nonatomic, readonly) ResponseDataFormat responseFormat;
/*!
 *  应答的数据
 */
@property(nonatomic, readonly) COResponseData *responseData;
@end
