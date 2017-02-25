//
//  NATableViewCell.h
//  NewsApp
//
//  Created by BRABUS on 2/24/17.
//  Copyright © 2017 Anthony Zhdanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NATableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTypeLabel;

@end
