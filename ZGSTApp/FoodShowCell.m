//
//  FoodShowCell.m
//  ZGSTApp
//
//  Created by tusm on 15/12/22.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "FoodShowCell.h"

@implementation FoodShowCell

- (void)awakeFromNib {
    
    self.moreBtn.layer.cornerRadius = 13;
    self.moreBtn.layer.masksToBounds = YES;
    self.moreBtn.layer.borderWidth = 0.5;
    self.moreBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    
    self.lessBtn.layer.cornerRadius = 13;
    self.lessBtn.layer.masksToBounds = YES;
    self.lessBtn.layer.borderWidth = 0.5;
    self.lessBtn.layer.borderColor = [UIColor orangeColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
