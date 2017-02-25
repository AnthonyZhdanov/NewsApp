//
//  NANewsAPI.m
//  NewsApp
//
//  Created by BRABUS on 2/23/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NANewsAPI.h"
#import "NAWebServices.h"
#import "NADataManager.h"

@interface NANewsAPI () {
    NAWebServices *webServices;
    NADataManager *dataManager;
}
@end

@implementation NANewsAPI
//Singletone
+ (NANewsAPI *)sharedInstance {
    static NANewsAPI * _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [NANewsAPI new];
    });
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self)
    {
        webServices = [NAWebServices new];
        dataManager = [NADataManager new];
    }
    return self;
}

- (void)loadDataWithString:(NSString *)string {
    [webServices loadDataWithString:string withCompletionBlock:^(id loadedData) {
        [dataManager addDataToManager:loadedData];
    }];
}

- (NSArray *)loadedData {
    return [dataManager loadedData];
}

@end
