//
//  NALoadingActivityIndicator.m
//  NewsApp
//
//  Created by BRABUS on 3/15/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NALoadingActivityIndicator.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface NALoadingActivityIndicator ()

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation NALoadingActivityIndicator

+ (instancetype)sharedLoadingActivityIndicator {
    static NALoadingActivityIndicator *_sharedInstance;
    if (_sharedInstance == nil) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _sharedInstance = [[super alloc] initPrivate];
        });
    }
    return _sharedInstance;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
    }
    return self;
}
#pragma mark - Loader
- (void)showLoader {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.hud == nil) {
            UIView *curentView = [[[UIApplication sharedApplication] windows] lastObject];
            self.hud = [MBProgressHUD showHUDAddedTo:curentView animated:YES];
            self.hud.mode = MBProgressHUDModeIndeterminate;
            self.hud.label.text = @"Loading";
            self.hud.bezelView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        }
        [self.hud showAnimated:YES];
    });
//}];
//
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (self.hud == nil) {
//            UIView *curentView = [[[UIApplication sharedApplication] windows] lastObject];
//            self.hud = [MBProgressHUD showHUDAddedTo:curentView animated:YES];
//            self.hud.mode = MBProgressHUDModeAnnularDeterminate;
//            self.hud.label.text = @"Loading";
//            self.hud.bezelView.backgroundColor = [UIColor whiteColor];
//        }
//        [self.hud showAnimated:YES];
//    });
}

- (void)hideLoader {
    if (self.hud) {
        [self.hud hideAnimated:YES];
        [self.hud removeFromSuperview];
        self.hud = nil;
    }
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    [self.hud removeFromSuperview];
    self.hud = nil;
}

@end
