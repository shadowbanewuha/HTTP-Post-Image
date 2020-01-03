//
//  main.m
//  YHONetworkFetcher
//
//  Created by lovingc2009 on 16/11/21.
//  Copyright © 2016年 YHO. All rights reserved.
//

#import "YHONetWorkRequest.h"
#import "YHONetworkPicUpload.h"

int main(int argc, char * argv[]) {
    UIImage *image1 = [UIImage imageNamed:@"1.png"];
    YHONetWorkRequest *request = [[YHONetWorkRequest alloc] initWithUrlString:@"http://127.0.0.1:6186"];
    [request configRequest:^(NSMutableURLRequest *request){
        NSDictionary *dic = @{
                              @"appkey" : @"dhaljd",
                              @"content" : @"真心太好用了"
                              };
        
        
        YHONetworkPicUpload *picUpload = [[YHONetworkPicUpload alloc] init];
        picUpload.parameters = dic;
        picUpload.boundary = @"AaB03x";
        picUpload.pictures = @[createPNGPicture(@"AaB03x", image1, @"image1", @"1.png")];
        
        [picUpload configRequest:&request];
    }];
}
