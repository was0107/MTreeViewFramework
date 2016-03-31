//
//  ContactTableViewCell.m
//  MTreeViewFramework
//
//  Created by Micker on 16/3/31.
//  Copyright © 2016年 micker. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userImageView.layer.cornerRadius = 25.0f;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.backgroundColor = [UIColor lightGrayColor];
    self.separatorInset = UIEdgeInsetsMake(0, 65, 0, 0);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
