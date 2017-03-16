//
//  ViewController.m
//  NewsApp
//
//  Created by BRABUS on 2/23/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NAMainViewController.h"
#import "NAAppConstanst.h" //all constants
#import "NANewsAPI.h"
#import "NATableViewCellOnMainViewController.h"
#import <AFnetworking/UIImageView+AFNetworking.h>
#import "SWRevealViewController.h"
#import "NAArticlesViewController.h"
#import "NANewsModel.h"
#import "NALoadingActivityIndicator.h"

@interface NAMainViewController () <UITableViewDelegate, UITableViewDataSource, SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *newsArray;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSString *articlesPath;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation NAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.revealViewController.delegate = self;
    //show indicator while data loading and parsing and setup
    [[NALoadingActivityIndicator sharedLoadingActivityIndicator] showLoader];
    //background setup
    self.backgroundImageView.image = [UIImage imageNamed:@"backgroundImage"];
    self.tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self loadDataFromOutside:kAllSourcesList];
    //setup for sidebar
    [self setupForSidebar];
    //catch message that data loaded and start operations with it
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTableView)
                                                 name:@"NADataReady"
                                               object:nil];
}

#pragma mark - Private
- (void)loadDataFromOutside:(NSString *)string {
    [[NALoadingActivityIndicator sharedLoadingActivityIndicator] showLoader];
    [[NANewsAPI sharedInstance] loadDataWithString:string];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showArticles"]) {
        NAArticlesViewController *articlesController = segue.destinationViewController;
        articlesController.articlesPath = self.articlesPath;
    }
}

- (void)setupForSidebar {
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setImage:[UIImage imageNamed:@"sidebarButton"]];
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)updateTableView {
    //getting data from storage
    self.newsArray = [[NANewsAPI sharedInstance] loadedData];
    dispatch_async(dispatch_get_main_queue(), ^{
        //reload visible part of tableView
        [self.tableView reloadData];
        [[NALoadingActivityIndicator sharedLoadingActivityIndicator] hideLoader];
    });
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    NATableViewCellOnMainViewController *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NANewsModel *sourceItem = self.newsArray[indexPath.row];
    
    cell.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
  
    cell.headerTextLabel.text = sourceItem.sourceName;
    cell.descriptionTextLabel.text = sourceItem.sourceDescription;
    
    [cell.newsLogoImageView setImageWithURL:sourceItem.sourceImageURL placeholderImage:[UIImage imageNamed:@"noImage"]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NANewsModel *newsItem = self.newsArray[indexPath.row];
    //assembling string with pass to articles by selected recource
    self.articlesPath = [NSString stringWithFormat:@"%@%@%@", kArticlesList, newsItem.sourceIdentifier, kApiKey];
    //performing segue to view controller which will show articles list to us
    [self performSegueWithIdentifier:@"showArticles" sender:self];
}
#pragma mark - SWRevealViewControllerDelegate
//here I disable interaction with main view when left view is opened
- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    self.tableView.userInteractionEnabled =
    (revealController.frontViewPosition == FrontViewPositionRight ? NO : YES);
}

@end
