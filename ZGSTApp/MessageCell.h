//
//  MessageCell.h
//  MallApp
//
//  Created by tusm on 15/12/9.
//  Copyright © 2015年 fady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImage;

@property (strong, nonatomic) IBOutlet UILabel *headLine;

@property (strong, nonatomic) IBOutlet UILabel *messageLabel;


@end
