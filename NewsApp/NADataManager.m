//
//  NADataManager.m
//  NewsApp
//
//  Created by BRABUS on 2/23/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NADataManager.h"
#import "NANewsModel.h"

@interface NADataManager () {
    NSArray *loadedData;
}

@end

@implementation NADataManager

- (void)addDataToManager:(id)data {
    loadedData = [NSArray new];
    //creating objects with loaded data by model
    if (data[@"sources"]) {
        NSMutableArray *mutArrWithSources = [NSMutableArray new];
        for (NSDictionary *sourcesData in data[@"sources"]) {
            NANewsModel *source = [[NANewsModel alloc] initWithSourceName:sourcesData[@"name"]
                                                        sourceDescription:sourcesData[@"description"]
                                                           sourceImageURL:sourcesData[@"urlsToLogos"][@"small"]
                                                         sourceIdentifier:sourcesData[@"id"]];
            [mutArrWithSources addObject:source];
            loadedData = [mutArrWithSources copy];
        }
        //sending message that data is ready
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NADataReady"
                                                            object:self
                                                          userInfo:nil];
    }
    else if (data[@"articles"]) {
        NSMutableArray *mutArrWithSources = [NSMutableArray new];
        for (NSDictionary *articlesData in data[@"articles"]) {
            NANewsModel *article = [[NANewsModel alloc] initWithArticleTitle:articlesData[@"title"]
                                                          articleDescription:articlesData[@"description"]
                                                             articleImageURL:articlesData[@"urlToImage"]
                                                              articlePageURL:articlesData[@"url"]];
            [mutArrWithSources addObject:article];
            loadedData = [mutArrWithSources copy];
        }
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
