//
//  NANewsModel.h
//  NewsApp
//
//  Created by BRABUS on 2/26/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NANewsModel : NSObject

@property (nonatomic, copy, readonly) NSString *sourceName;
@property (nonatomic, copy, readonly) NSString *sourceDescription;
@property (nonatomic, copy, readonly) NSURL *sourceImageURL;
@property (nonatomic, copy, readonly) NSString *sourceIdentifier;

@property (nonatomic, copy, readonly) NSString *articleTitle;
@property (nonatomic, copy, readonly) NSString *articleDescription;
@property (nonatomic, copy, readonly) NSURL *articleImageURL;
@property (nonatomic, copy, readonly) NSURL *articlePageURL;


- (id)initWithSourceName:(NSString *)name
       sourceDescription:(NSString *)description
          sourceImageURL:(NSString *)url
        sourceIdentifier:(NSString *)identifier;

- (id)initWithArticleTitle:(NSString *)title
        articleDescription:(NSString *)description
           articleImageURL:(NSString *)url
            articlePageURL:(NSString *)articleURL;

@end
