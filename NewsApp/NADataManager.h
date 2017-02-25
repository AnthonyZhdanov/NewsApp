//
//  NADataManager.h
//  NewsApp
//
//  Created by BRABUS on 2/23/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NADataManager : NSObject

- (void)addDataToManager:(id)data;
- (NSArray *)loadedData;

@end
