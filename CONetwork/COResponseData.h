//
//  COResponseData.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/13.
//
//

#import <Foundation/Foundation.h>



/*!
 *  网络应答的数据类型
 */
typedef enum {
    ResponseDataUnknown = 0,
    ResponseDataNone,
    ResponseDataNull,
    ResponseDataNumber,
    ResponseDataString,
    ResponseDataArray,
    ResponseDataDictionary
} ResponseDataType;

@interface COResponseData : NSObject
{
@private
    id _data;
    BOOL _isAllowNull;
    ResponseDataType _dataType;
}

- (id)initWithData:(id)data;

/**
 *  原始数据
 */
@property(nonatomic, strong, readonly) id data;
/*!
 *  网络应答的数据类型
 */
@property(nonatomic, readonly) ResponseDataType dataType;


@end