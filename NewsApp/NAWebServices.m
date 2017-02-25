//
//  NAWebServices.m
//  NewsApp
//
//  Created by BRABUS on 2/23/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NAWebServices.h"
@import AFNetworking;

@implementation NAWebServices

- (void)loadDataWithString:(NSString *)string withCompletionBlock:(void (^)(id))completionBlock {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *downloadTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
        else {
            completionBlock(responseObject);
        }
    }];
    [downloadTask resume];
}

@end
