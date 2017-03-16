//
//  NALoadingActivityIndicator.h
//  NewsApp
//
//  Created by BRABUS on 3/15/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NALoadingActivityIndicator : NSObject

// clue for improper use (produces compile time error)
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

+ (instancetype)sharedLoadingActivityIndicator;

- (void)showLoader;

- (void)hideLoader;

@end
