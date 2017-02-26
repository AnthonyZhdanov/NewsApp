//
//  NAWebViewViewController.m
//  NewsApp
//
//  Created by BRABUS on 2/25/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NAWebViewViewController.h"

@interface NAWebViewViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *articlesWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *webViewActivityIndicator;

@end

@implementation NAWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.articlesWebView.delegate = self;
    //activity indicator setup
    self.webViewActivityIndicator.hidesWhenStopped = YES;
    self.webViewActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.webViewActivityIndicator.color = [UIColor blackColor];
    
    if (self.urlToArticle) {
        //loadRequest by URL with page adress
        NSURLRequest *requestPage = [NSURLRequest requestWithURL:self.urlToArticle];
        [self.articlesWebView loadRequest:requestPage];
    }
    // Do any additional setup after loading the view.
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.webViewActivityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webViewActivityIndicator stopAnimating];
}

@end
