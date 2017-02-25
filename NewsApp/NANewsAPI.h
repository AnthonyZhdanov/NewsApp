//
//  NANewsAPI.h
//  NewsApp
//
//  Created by BRABUS on 2/23/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NANewsAPI : NSObject

+ (NANewsAPI *)sharedInstance;
- (void)loadDataWithString:(NSString *)string;
- (NSArray *)loadedData;

@end
