//
//  AudioListTableViewCell.h
//  Audio Player
//
//  Created by Denis on 3/19/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
