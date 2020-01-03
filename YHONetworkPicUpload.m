//
//  YHONetworkPicUpload.m
//  YHONetworkFetcher
//
//  Created by lovingc2009 on 17/6/13.
//  Copyright © 2017年 YHO. All rights reserved.
//

#import "YHONetworkPicUpload.h"

@implementation YHONetworkPicUpload

//创建图片POST头部信息
- (NSData *)createParametersData {
    NSString *start = [NSString stringWithFormat:@"--%@", _boundary];
    NSMutableString *body = [[NSMutableString alloc] init];
    
    NSArray *keys = [_parameters allKeys];
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *key = keys[idx];
        [body appendFormat:@"\r\n%@\r\n", start];
        [body appendFormat:@"Content-Dispostion: form-data; name=\"%@\"\r\n\r\n", key];
        [body appendFormat:@"%@",_parameters[key]];
    }];
    
    return [body dataUsingEncoding:NSUTF8StringEncoding];
}

//创建图片POST尾部信息
- (NSData *)createEndData{
    NSString *end = [NSString stringWithFormat:@"\r\n--%@--\r\n", _boundary];
    return [end dataUsingEncoding:NSUTF8StringEncoding];
}

//生成POST需要的数据格式
- (NSData *)createPostData {
    if (_boundary && _parameters) {
        NSMutableData *postData = [NSMutableData data];
        //添加头
        [postData appendData:[self createParametersData]];
        
        //添加图片
        [_pictures enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[NSData class]]) {
                [postData appendData:obj];
            }
        }];
        
        //添加尾
        [postData appendData:[self createEndData]];
        
        return postData;
    }
    return nil;
}

//创建PNG格式的图片
NSData *createPNGPicture(NSString *formBoundary,
                         UIImage *image,
                         NSString *name,
                         NSString *filename) {
    NSString *start = [NSString stringWithFormat:@"--%@", formBoundary];
    
    //添加分界线，换行
    NSMutableString *subBody = [[NSMutableString alloc] init];
    [subBody appendFormat:@"\r\n%@\r\n", start];
    [subBody appendFormat:@"Content-Dispostion: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename];
    
    //声明上传文件的格式
    [subBody appendFormat:@"Content-Type: image/png\r\n\r\n"];
    
    //图片data
    NSData *imageData = [UIImagePNGRepresentation(image)  base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    //生成图片data
    NSMutableData *tempData = [NSMutableData data];
    [tempData appendData:[subBody dataUsingEncoding:NSUTF8StringEncoding]];
    [tempData appendData:imageData];
    
    return [NSData dataWithData:tempData];
}

- (void)configRequest:(NSMutableURLRequest *__autoreleasing *)request {
    // 获取到POST包体
    NSData *data = [self createPostData];
    
    //配置请求
    NSMutableURLRequest *tmpRequest = *request;
    
    //设置请求POST包体
    tmpRequest.HTTPBody = data;
    tmpRequest.HTTPMethod = @"POST";
    
    //设置HTTPHeaderField
    [tmpRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    [tmpRequest setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", _boundary] forHTTPHeaderField:@"Content-Type"];
}

@end
