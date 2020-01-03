//
//  YHONetWorkRequest.m
//  YHONetworkFetcher
//
//  Created by lovingc2009 on 17/6/13.
//  Copyright © 2017年 YHO. All rights reserved.
//

#import "YHONetWorkRequest.h"

@implementation YHONetWorkRequest {
    /* base URL */
    NSURL *_baseUrl;
    /* session */
    NSURLSession *_session;
}

- (instancetype)initWithUrlString:(NSString *)string {
    self = [super init];
    _baseUrl = [NSURL URLWithString:string];
    _session = [NSURLSession sharedSession];
    return self;
}

- (void)configRequest:(void (^)(NSMutableURLRequest *request))configHandle {
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:_baseUrl];
    request.timeoutInterval = 1800;
    configHandle(request);
    
    NSURLSessionUploadTask *task = [_session uploadTaskWithRequest:request
                                                          fromData:request.HTTPBody
                                                 completionHandler:^(NSData *data,
                                                                     NSURLResponse *rep,
                                                                     NSError *error){
        if (error) {
            NSLog(@"Upload error : %@", error.localizedDescription);
        }
    }];
    [task resume];
}

@end
