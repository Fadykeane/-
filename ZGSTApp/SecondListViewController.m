//
//  SecondListViewController.m
//  ZGSTApp
//
//  Created by tusm on 15/12/22.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "SecondListViewController.h"

#define SellerReuser @"sellReuser"
#define OneReuser @"oneReuser"
#define TwoReuser @"twoReusr"
#define ThirdReuser @"thirdReuser"


#import "NearbySellerCell.h"
#import "SellerViewController.h"

@interface SecondListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *openSelectView;
    
    UITableView *tableOne;
    
    UITableView *tableSecond;

    UITableView *tableThird;

    UITableView *tableFour;
    //中间传值介质
    NSString *optionFStr;
    NSString *optionSStr;
    NSString *optionTStr;
    
}

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation SecondListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"外卖";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //
    self.tabBarController.tabBar.hidden = YES;
    
    [self optionLayout];
    
    [self tableViewLayout];
    
 
    
}

-(void)optionLayout{
    
    NSArray *optionArr = @[@"美食",@"综合排序",@"优惠活动"];
    CGFloat perWidth = Screen_Width/3;
    for (int i = 0; i<3; i++) {
        //
        UIView *optionView = [[UIView alloc]initWithFrame:CGRectMake(perWidth*i, 0, perWidth, 40)];
        
        optionView.layer.borderWidth = 1;
        optionView.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
        //增加手势
        UITapGestureRecognizer *tapVWGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapVWAction:)];
        optionView.userInteractionEnabled = YES;
        [optionView addGestureRecognizer:tapVWGesture];
        
        optionView.tag = i;
        //
        NSString *opStr = optionArr[i];
        CGSize size =[opStr sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
        
        UILabel *optionLB = [[UILabel alloc]initWithFrame:CGRectMake(perWidth/2-size.width/2, 10, size.width, 20)];
        optionLB.text = opStr;
        optionLB.textColor = [UIColor darkGrayColor];
        optionLB.textAlignment = 1;
        optionLB.font = [UIFont boldSystemFontOfSize:16];
        
        [optionView addSubview:optionLB];
        //
        UIImageView *openImage = [[UIImageView alloc]initWithFrame:CGRectMake(optionLB.frame.origin.x+optionLB.frame.size.width+10, optionLB.frame.origin.y+5, 10, 7)];
        openImage.image = [UIImage imageNamed:@"open_01"];
        
        [optionView addSubview:openImage];
        
        [self.view addSubview:optionView];
    }
}

#pragma mark---tableview
-(void)tableViewLayout{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, Screen_Width, Screen_Height-64-40) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NearbySellerCell" bundle:nil] forCellReuseIdentifier:SellerReuser];
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

#pragma mark-----手势方法
-(void)tapVWAction:(UITapGestureRecognizer *)sender{
    
    openSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, Screen_Width, Screen_Height-64-40)];
    openSelectView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    
    [self.view addSubview:openSelectView];
    //这里sender.view可以拿到加了手势的View视图
    if (sender.view.tag == 0) {
        //在此之前先移除两个tableview
        [tableThird removeFromSuperview];
        [tableFour removeFromSuperview];
        [tableSecond removeFromSuperview];
        //
        tableOne = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width/2, Screen_Height/2)];
        tableOne.delegate = self;
        tableOne.dataSource = self;
        
        tableOne.showsVerticalScrollIndicator = NO;

        [tableOne registerClass:[UITableViewCell class] forCellReuseIdentifier:OneReuser];
        
        [openSelectView addSubview:tableOne];

    }
    
    if (sender.view.tag == 1) {
        //在此之前先移除两个tableview
        [tableOne removeFromSuperview];
        [tableSecond removeFromSuperview];
        [tableFour removeFromSuperview];
        //再加载
        tableThird = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
        tableThird.delegate = self;
        tableThird.dataSource = self;
        
        tableThird.showsVerticalScrollIndicator = NO;

        [tableThird registerClass:[UITableViewCell class] forCellReuseIdentifier:OneReuser];
        
        [openSelectView addSubview:tableThird];

        tableThird.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    
    if (sender.view.tag == 2) {
        //在此之前先移除两个tableview
        [tableThird removeFromSuperview];
        [tableOne removeFromSuperview];
        [tableSecond removeFromSuperview];
        //再加载
        tableFour = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 320)];
        tableFour.delegate = self;
        tableFour.dataSource = self;
        
        [tableFour registerClass:[UITableViewCell class] forCellReuseIdentifier:OneReuser];
        
        [openSelectView addSubview:tableFour];
        
        tableFour.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    
}
//消失View
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [openSelectView removeFromSuperview];
}
#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _tableView) {
        return 1;
    }else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _tableView) {
        return 20;
    }else if(tableView == tableThird){
        return 5;
    }else if(tableView == tableFour){
        return 8;
    }else{
        return 10;
    }
}

//懒加载，部分协议内的代码在点击后才加载，有if作为判断
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tableView) {
        
        NearbySellerCell *cell = [tableView dequeueReusableCellWithIdentifier:SellerReuser];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (tableView == tableOne){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OneReuser];
        
        NSArray *oneArr = @[@"美食",@"快餐小吃",@"火锅",@"海鲜/烧烤",@"特色菜",@"烤鱼",@"地方菜",@"东南亚菜",@"西餐",@"日韩料理"];
        
        cell.textLabel.text = oneArr[indexPath.row];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else if(tableView == tableSecond){//这里是tableSecond表格
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OneReuser];
        
        cell.textLabel.text = [NSString stringWithFormat:@"菜品%d",arc4random() % 100];
        cell.textLabel.textColor = [UIColor darkGrayColor];

        cell.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        
        return cell;
    }else if(tableView == tableThird){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OneReuser];
        
        NSArray *oneArr = @[@"综合排序",@"销量最高",@"速度最快",@"评分最高",@"起送价最低"];
        
        cell.textLabel.text = oneArr[indexPath.row];
        cell.textLabel.textColor = [UIColor darkGrayColor];

        return cell;

    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OneReuser];
        
        NSArray *oneArr = @[@"首单立减",@"满减优惠",@"满返代金券",@"折扣商品",@"聘外卖员",@"增清凉茶饮料250ml",@"满赠活动",@"免费配送"];
        
        cell.textLabel.text = oneArr[indexPath.row];
        cell.textLabel.textColor = [UIColor darkGrayColor];

        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tableView) {
        return 150;
    }else{
        return 40;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tableView) {
        
        SellerViewController *sellerVC = [[SellerViewController alloc]init];
        
        [self.navigationController pushViewController:sellerVC animated:YES];
        
    }
    if (tableView == tableOne) {
        //移除后重加载
        [tableSecond removeFromSuperview];
        //
        tableSecond = [[UITableView alloc]initWithFrame:CGRectMake(Screen_Width/2, 0, Screen_Width/2, Screen_Height/2)];
        tableSecond.delegate = self;
        tableSecond.dataSource = self;
        
        tableSecond.showsVerticalScrollIndicator = NO;

        [tableSecond registerClass:[UITableViewCell class] forCellReuseIdentifier:OneReuser];
        
        [openSelectView addSubview:tableSecond];
        //对option上是字符串改变
        UILabel *thisLB = (UILabel *)[((UIView *)[self.view.subviews firstObject]).subviews firstObject];
        
         NSArray *oneArr = @[@"美食",@"快餐小吃",@"火锅",@"海鲜/烧烤",@"特色菜",@"烤鱼",@"地方菜",@"东南亚菜",@"西餐",@"日韩料理"];
        
        CGSize size =[oneArr[indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
        
        thisLB.frame = CGRectMake(Screen_Width/6-size.width/2, 10, size.width, 20);
        thisLB.text = oneArr[indexPath.row];
        
    }
    
    if (tableView == tableSecond ||tableView == tableThird||tableView == tableFour) {
        [openSelectView removeFromSuperview];
    }
    
    if (tableView == tableThird) {
        //对option上是字符串改变
        UILabel *thisLB = (UILabel *)[((UIView *)[self.view.subviews objectAtIndex:1]).subviews firstObject];
        
        NSArray *oneArr = @[@"综合排序",@"销量最高",@"速度最快",@"评分最高",@"起送价最低"];
        
        CGSize size =[oneArr[indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
        
        thisLB.frame = CGRectMake(Screen_Width/6-size.width/2, 10, size.width, 20);
        thisLB.text = oneArr[indexPath.row];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
