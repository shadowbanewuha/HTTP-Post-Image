//
//  YHONetWorkRequest.h
//  YHONetworkFetcher
//
//  Created by lovingc2009 on 17/6/13.
//  Copyright © 2017年 YHO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHONetWorkRequest : NSObject

- (instancetype)initWithUrlString:(NSString *)string;

- (void)configRequest:(void (^)(NSMutableURLRequest *request))configHandle;

@end
