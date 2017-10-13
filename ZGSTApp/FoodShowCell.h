//
//  FoodShowCell.h
//  ZGSTApp
//
//  Created by tusm on 15/12/22.
//  Copyright © 2015年 fady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodShowCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *moreBtn;

@property (strong, nonatomic) IBOutlet UIButton *lessBtn;

@property (strong, nonatomic) IBOutlet UILabel *numLB;

@property (strong, nonatomic) IBOutlet UILabel *perPriceLB;

@end
