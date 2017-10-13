//
//  ZGSTController.m
//  ZGSTApp
//
//  Created by tusm on 15/12/21.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "ZGSTController.h"

@interface ZGSTController ()

@end

@implementation ZGSTController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tabBar setTintColor:[UIColor orangeColor]];
    
    //
    UITabBarItem * item1 = (UITabBarItem *)[self.tabBar.items firstObject];
    item1.selectedImage = [UIImage imageNamed:@"home2"];
    
    UITabBarItem *item2 = (UITabBarItem *)[self.tabBar.items objectAtIndex:1];
    item2.selectedImage = [UIImage imageNamed:@"select2"];
    
    UITabBarItem * item3 = (UITabBarItem *)[self.tabBar.items objectAtIndex:2];
    item3.selectedImage = [UIImage imageNamed:@"my2"];
    //    这里设置加载进来时购物车里物品的个数
    UITabBarItem * item4 = (UITabBarItem *)[self.tabBar.items objectAtIndex:3];
    item4.selectedImage = [UIImage imageNamed:@"more2"];
    //

//    NSInteger number = [[NSUserDefaults standardUserDefaults]integerForKey:@"dingdan"];
//    if (number||number != 0) {
//        
//        item2.badgeValue = [NSString stringWithFormat:@"%ld",(long)number];
//    }
    //

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
