//
//  NANewsModel.m
//  NewsApp
//
//  Created by BRABUS on 2/26/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NANewsModel.h"

@implementation NANewsModel

- (id)initWithSourceName:(NSString *)name
       sourceDescription:(NSString *)description
          sourceImageURL:(NSString *)url
        sourceIdentifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        _sourceName = name;
        _sourceDescription = description;
        _sourceImageURL = [NSURL URLWithString:url];
        _sourceIdentifier = identifier;
    }
    return self;
}

- (id)initWithArticleTitle:(NSString *)title
        articleDescription:(NSString *)description
           articleImageURL:(NSString *)url
            articlePageURL:(NSString *)articleURL
{
    self = [super init];
    if (self) {
        _articleTitle = title;
        _articleDescription = description;
        _articleImageURL = [NSURL URLWithString:url];
        _articlePageURL = [NSURL URLWithString:articleURL];
    }
    return self;
}


@end
