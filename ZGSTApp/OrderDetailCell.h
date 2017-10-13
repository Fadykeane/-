//
//  OrderDetailCell.h
//  ZGSTApp
//
//  Created by tusm on 15/12/23.
//  Copyright © 2015年 fady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *perPrice;

@property (strong, nonatomic) IBOutlet UILabel *totalPrice;

@end
