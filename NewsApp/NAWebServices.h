//
//  NAWebServices.h
//  NewsApp
//
//  Created by BRABUS on 2/23/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAWebServices : NSObject

- (void)loadDataWithString:(NSString *)string withCompletionBlock:(void(^)(id))completionBlock;

@end
