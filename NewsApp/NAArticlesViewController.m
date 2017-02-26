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
#import "NANewsModel.h"

@interface NAArticlesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *arrayOfArticles;
@property (weak, nonatomic) IBOutlet UITableView *articlesTableView;
@property (weak, nonatomic) IBOutlet UIImageView *articlesBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *articlesLoadingActivityIndicator;
@property (strong, nonatomic) NSURL *pathToArticle;

@end

@implementation NAArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //show indicator while data loading and parsing and setup
    self.articlesLoadingActivityIndicator.hidesWhenStopped = YES;
    self.articlesLoadingActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.articlesLoadingActivityIndicator.color = [UIColor whiteColor];
    [self.articlesLoadingActivityIndicator startAnimating];
    //load data to display
    NSString *path = self.articlesPath;
    [[NANewsAPI sharedInstance] loadDataWithString:path];
    //background setup
    self.articlesBackgroundImageView.image = [UIImage imageNamed:@"backgroundImage"];
    self.articlesTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    //catch message that data loaded and start operations with it
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTableView)
                                                 name:@"NAArticlesDataReady"
                                               object:nil];
}

#pragma mark - Private
- (void)loadDataFromOutside:(NSString *)string {
    [[NANewsAPI sharedInstance] loadDataWithString:string];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showWebView"]) {
        NAWebViewViewController *webViewController = segue.destinationViewController;
        NSURL *urlToArticles = self.pathToArticle;
        webViewController.urlToArticle = urlToArticles;
    }
}

- (void)updateTableView {
    //getting data from storage, creating objects by model and then reloading tableView
    NSMutableArray *mutArrWithSources = [NSMutableArray new];
    self.arrayOfArticles = [[NANewsAPI sharedInstance] loadedData];
    
    for (NSDictionary *articlesData in self.arrayOfArticles) {
        NANewsModel *article = [[NANewsModel alloc] initWithArticleTitle:articlesData[@"title"]
                                                      articleDescription:articlesData[@"description"]
                                                         articleImageURL:articlesData[@"urlToImage"]
                                                          articlePageURL:articlesData[@"url"]];
        [mutArrWithSources addObject:article];
        self.arrayOfArticles = [mutArrWithSources copy];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        //reload visible part of tableView
        [self.articlesTableView reloadData];
    });
    [self.articlesLoadingActivityIndicator stopAnimating];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfArticles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"articles";
    NATableViewCellOnArticlesViewController *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NANewsModel *articleItem = self.arrayOfArticles[indexPath.row];

    cell.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];

    cell.articleTitleLabel.text = articleItem.articleTitle;
    cell.articleDescriptionLabel.text = articleItem.articleDescription;
    [cell.articleImageView setImageWithURL:articleItem.articleImageURL placeholderImage:[UIImage imageNamed:@"noImage"]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NANewsModel *articleItem = self.arrayOfArticles[indexPath.row];
//    NSLog(@"%@", articlesDict);
    //Take url to load in web view
    self.pathToArticle = articleItem.articlePageURL;
    [self performSegueWithIdentifier:@"showWebView" sender:self];
}

@end
