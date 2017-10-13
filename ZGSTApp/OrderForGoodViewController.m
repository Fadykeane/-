//
//  OrderForGoodViewController.m
//  MallApp
//
//  Created by tusm on 15/12/4.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "OrderForGoodViewController.h"

#define CellId @"cellId"
#define OrderSction @"cellOrderSection"


#import "OrderSectionCell.h"
#import "OrderCell.h"
#import "OrderDetailViewController.h"
#import "SellerViewController.h"

@interface OrderForGoodViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation OrderForGoodViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订单";
    
    [self tableViewLayout];
    [self initNavigationBar];
    
}

-(void)initNavigationBar{
    //
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    cancelBtn.frame = CGRectMake(0, 0, 40, 30);
    
    [cancelBtn setTitle:@"编辑" forState:0];
    
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:0];

    [cancelBtn addTarget:self action:@selector(editsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    
    self.navigationItem.rightBarButtonItem = right;
    
}

-(void)editsAction:(UIButton *)sender{
    
}

-(void)tableViewLayout{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:CellId];
    [_tableView registerNib:[UINib nibWithNibName:@"OrderSectionCell" bundle:nil] forCellReuseIdentifier:OrderSction];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        OrderSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderSction];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        
        OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 40;
    }else
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
        OrderDetailViewController *detailVC = [[OrderDetailViewController alloc]init];
        
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else{
        
        SellerViewController *sellerVC = [SellerViewController new];
        
        [self.navigationController pushViewController:sellerVC animated:YES];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
