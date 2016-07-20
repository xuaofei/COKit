//
//  COResponse.m
//  BusinessShow
//
//  Created by xuaofei on 16/6/13.
//
//

#import "CORequest.h"
#import "COResponse.h"


@implementation COResponse
+ (ResponseDataFormat)responseDataFormat
{
    return ResponseDataFormatJson;
}


- (ResponseDataFormat)responseFormat
{
    return [[self class] responseDataFormat];
}

- (void)parseData:(id)data
{
    if (!data) {
        self.isError = YES;
        return;
    }
    
    
    if (self.responseFormat == ResponseDataFormatJson)
    {
        self.errorCode = [data objectForKey:@"MSG_COD"];
        self.errorMsg = [data objectForKey:@"MSG_INF"];
        

        self.isError = (BOOL)[self.errorCode integerValue];
    }
    else if (self.responseFormat == ResponseDataFormatString)
    {
        
    }
}

- (void)setData:(id)data
{
    self.isError = YES;
    _data = data;
    
    if (_data) {
        [self parseData:_data];
    }
}
@end
