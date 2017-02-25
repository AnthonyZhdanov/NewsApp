//
//  NATableViewController.m
//  NewsApp
//
//  Created by BRABUS on 2/24/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import "NATableViewController.h"
#import "NAAppConstanst.h"
#import "NATableViewCell.h"
#import "SWRevealViewController.h"
#import "NAMainViewController.h"

@interface NATableViewController ()

@property NSArray *arrayOfConst;
@property (weak, nonatomic) IBOutlet UILabel *newsTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsTypeLogoImageView;
@property NAMainViewController *mainViewControllerInstance;

@end

@implementation NATableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainViewControllerInstance = [NAMainViewController new];
    self.arrayOfConst = @[kAllCategories, kBusiness, kEntertainment, kGaming, kGeneral, kMusic, kScienceAndNature, kSport, kTechnology];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfConst.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"leftViewCell";
    NATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.newsTypeLabel.text = [self.arrayOfConst[indexPath.row] capitalizedString];
    cell.newsTypeImageView.image = [UIImage imageNamed:@"noImage"];
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *stringWithCategory = self.arrayOfConst[indexPath.row];
    NSString *string = [NSString stringWithFormat:@"%@%@", kSeparateCategory, stringWithCategory];
    [self.mainViewControllerInstance loadDataFromOutside:string];
    //hide sidebar after action
    [self.revealViewController revealToggleAnimated:YES];
}

@end
