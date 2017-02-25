//
//  NADataManager.m
//  NewsApp
//
//  Created by BRABUS on 2/23/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NADataManager.h"

@interface NADataManager () {
    NSArray *loadedData;
}

@end

@implementation NADataManager

- (void)addDataToManager:(id)data {
    loadedData = [NSArray new];
    
    if (data[@"sources"]) {
        loadedData = data[@"sources"];
        //sending message that data is ready
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NADataReady"
                                                            object:self
                                                          userInfo:nil];
    }
    else if (data[@"articles"]) {
        loadedData = data[@"articles"];
        //sending message that data is ready
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NAArticlesDataReady"
                                                            object:self
                                                          userInfo:nil];
    } else {
        NSLog(@"wrong dict");
    }
}

- (NSArray *)loadedData {
    return loadedData;
}

@end
