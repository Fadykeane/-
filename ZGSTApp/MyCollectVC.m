//
//  MyCollectVC.m
//  ZGSTApp
//
//  Created by tusm on 15/12/24.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "MyCollectVC.h"

#define CellId @"cellId"

#import "NearbySellerCell.h"
#import "SellerViewController.h"

@interface MyCollectVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MyCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tableViewLayout];
    
}

-(void)tableViewLayout{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NearbySellerCell" bundle:nil] forCellReuseIdentifier:CellId];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}


#pragma mark----action
-(void)editsAction{
    
    
}

#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearbySellerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SellerViewController *sellerVC = [[SellerViewController alloc]init];
    
    [self.navigationController pushViewController:sellerVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
