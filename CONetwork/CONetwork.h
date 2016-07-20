//
//  CONetwork.h
//  BusinessShow
//
//  Created by xuaofei on 16/6/14.
//
//

#ifndef CONetwork_h
#define CONetwork_h


/*!
 *  网络请求方法
 */
typedef enum {
    COURLMethodNone = 0,
    COURLUploadFile,
    COURLDownloadFile,
    COHttpMethodPost,
    COHttpMethodGet,
} CONetworkMethod;


typedef enum {
    ResponseDataFormatNone = 0,
    ResponseDataFormatJson,
    ResponseDataFormatXml,
    ResponseDataFormatString,
    ResponseDataFormatFile
} ResponseDataFormat;


#endif /* CONetwork_h */
