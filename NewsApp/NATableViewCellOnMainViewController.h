//
//  NATableViewCellOnMainViewController.h
//  NewsApp
//
//  Created by BRABUS on 2/23/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NATableViewCellOnMainViewController : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerTextLabel;

@end
