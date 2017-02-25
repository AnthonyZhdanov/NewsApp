//
//  NAArticlesViewController.m
//  NewsApp
//
//  Created by BRABUS on 2/25/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NAArticlesViewController.h"
#import "NANewsAPI.h"
#import "NATableViewCellOnArticlesViewController.h"
#import <AFnetworking/UIImageView+AFNetworking.h>
#import "NAWebViewViewController.h"

@interface NAArticlesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *arrayOfArticles;
@property (weak, nonatomic) IBOutlet UITableView *articlesTableView;
@property (weak, nonatomic) IBOutlet UIImageView *articlesBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *articlesLoadingActivityIndicator;
@property (strong, nonatomic) NSString *pathToArticle;

@end

@implementation NAArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //show indicator while data loading and parsing and setup
    self.articlesLoadingActivityIndicator.hidesWhenStopped = YES;
    self.articlesLoadingActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.articlesLoadingActivityIndicator.color = [UIColor whiteColor];
    [self.articlesLoadingActivityIndicator startAnimating];
    //background setup
    self.articlesBackgroundImageView.image = [UIImage imageNamed:@"backgroundImage"];
    self.articlesTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    //catch message that data loaded and start operations with it
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTableView)
                                                 name:@"NAArticlesDataReady"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSString *path = self.articlesPath;
    [[NANewsAPI sharedInstance] loadDataWithString:path];
}

#pragma mark - Private
- (void)loadDataFromOutside:(NSString *)string {
    [[NANewsAPI sharedInstance] loadDataWithString:string];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showWebView"]) {
        NAWebViewViewController *webViewController = segue.destinationViewController;
        NSURL *urlToArticles = [NSURL URLWithString:self.pathToArticle];
        webViewController.urlToArticle = urlToArticles;
    }
}

- (void)updateTableView {
    //getting data from storage and then reloading tableView
    self.arrayOfArticles = [[NANewsAPI sharedInstance] loadedData];
    [self.articlesTableView reloadData];
    [self.articlesLoadingActivityIndicator stopAnimating];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfArticles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"articles";
    NATableViewCellOnArticlesViewController *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *newsList = self.arrayOfArticles[indexPath.row];
    NSString *pathToImage;

    cell.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];

    cell.articleTitleLabel.text = newsList[@"title"];
    cell.articleDescriptionLabel.text = newsList[@"description"];
    pathToImage = newsList[@"urlToImage"];
    NSURL *url = [NSURL URLWithString:pathToImage];

    [cell.articleImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"noImage"]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *articlesDict = self.arrayOfArticles[indexPath.row];
//    NSLog(@"%@", articlesDict);
    //Take url to load in web view
    self.pathToArticle = articlesDict[@"url"];
    [self performSegueWithIdentifier:@"showWebView" sender:self];
}

@end
