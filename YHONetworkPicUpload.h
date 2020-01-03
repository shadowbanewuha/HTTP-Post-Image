//
//  YHONetworkPicUpload.h
//  YHONetworkFetcher
//
//  Created by lovingc2009 on 17/6/13.
//  Copyright © 2017年 YHO. All rights reserved.
//
/*
    利用Post请求携带参数上传图片
    HTTPBody部分需要客户端来配置， 分为3个部分
    ：头部发携带参数
    ：中间部分是要传输的图片
    ：尾部是结束标识
    除此之外，还需要配置一 下HTTPHeaderField 中的 Content-Length 以及 Content-Type
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/* Create pictures数组需要的数据 */
NSData *createPNGPicture(NSString *formBoundary, UIImage *image, NSString *name, NSString *filename);

@interface YHONetworkPicUpload : NSObject

@property (nonatomic, strong) NSString *boundary;       //分割字符串
@property (nonatomic, strong) NSDictionary *parameters; //携带的参数
@property (nonatomic, strong) NSArray *pictures;        //封装好的图片的数据

- (void)configRequest:(NSMutableURLRequest **)request;

@end
