//
//  NATableViewCellOnArticlesViewController.h
//  NewsApp
//
//  Created by BRABUS on 2/25/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NATableViewCellOnArticlesViewController : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleDescriptionLabel;

@end
