//
//  NAWebViewViewController.m
//  NewsApp
//
//  Created by BRABUS on 2/25/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NAWebViewViewController.h"
#import "NALoadingActivityIndicator.h"

@interface NAWebViewViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *articlesWebView;

@end

@implementation NAWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.articlesWebView.delegate = self;
    [[NALoadingActivityIndicator sharedLoadingActivityIndicator] showLoader];
    if (self.urlToArticle) {
        //loadRequest by URL with page adress
        NSURLRequest *requestPage = [NSURLRequest requestWithURL:self.urlToArticle];
        [self.articlesWebView loadRequest:requestPage];
    }
    // Do any additional setup after loading the view.
}
#pragma mark - UIWebViewDelegate
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    dispatch_async(dispatch_get_main_queue(), ^{;
        [[NALoadingActivityIndicator sharedLoadingActivityIndicator] hideLoader];
    });
}

@end
