      //
//  PayViewController.m
//  MallApp
//
//  Created by tusm on 15/12/14.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "PayViewController.h"

#define AddressReuser  @"addressReuser"
#define GoodsPayReuser @"goodsPayReuser"
#define HowToPayReuser @"howtoPayReuser"
#define PricePayReuser @"pricePayReuser"

#import "AddressPayCell.h"
#import "GoodsPayCell.h"
#import "HowToPayCell.h"
#import "PricePayCell.h"


@interface PayViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *totalBar;
    
    UILabel *totalLabel;
    
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation PayViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self totalBarLayout];
    
    [self navigationLayout];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [totalBar removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提交订单";

    [self tableViewLayout];
    
}

#pragma mark----导航栏布局
-(void)navigationLayout{
    
    //作为最右边的搜索图标
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    searchBtn.frame = CGRectMake(20, 0, 44, 44);
    
    [searchBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [searchBtn setImage:[UIImage imageNamed:@"home1"] forState:0];
    
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchBarBtn = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    self.navigationItem.rightBarButtonItem = searchBarBtn;
    
}

-(void)searchAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
 
}
-(void)tableViewLayout{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"AddressPayCell" bundle:nil] forCellReuseIdentifier:AddressReuser];
    [_tableView registerNib:[UINib nibWithNibName:@"GoodsPayCell" bundle:nil] forCellReuseIdentifier:GoodsPayReuser];
    [_tableView registerNib:[UINib nibWithNibName:@"HowToPayCell" bundle:nil] forCellReuseIdentifier:HowToPayReuser];
    [_tableView registerNib:[UINib nibWithNibName:@"PricePayCell" bundle:nil] forCellReuseIdentifier:PricePayReuser];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark----- 自定义去结算栏
-(void)totalBarLayout{
    
    totalBar = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-44, Screen_Width, 44)];
    totalBar.backgroundColor = [UIColor whiteColor];
    
    [self.tabBarController.view addSubview:totalBar];
    
    //
    CGFloat perWidth = (Screen_Width)/3;
    //合计显示
    totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, perWidth, 30)];
    totalLabel.text = @"待支付";
    totalLabel.textAlignment = 2 ;
    totalLabel.textColor = [UIColor blackColor];
    totalLabel.font = [UIFont systemFontOfSize:17];
    [totalBar addSubview:totalLabel];
    //
    
    NSString *firstLabel = [_totalValueStr substringWithRange:NSMakeRange(3, _totalValueStr.length-3)];
    
    UILabel *servePrice = [[UILabel alloc]initWithFrame:CGRectMake(15+perWidth, 10, perWidth-25, 30)];
    servePrice.text = firstLabel;
    servePrice.textAlignment = 0 ;
    servePrice.textColor = [UIColor redColor];
    servePrice.font = [UIFont systemFontOfSize:20];
    [totalBar addSubview:servePrice];
    
    //去结算按键
    UIButton *payBtn = [UIButton new];
    
    payBtn.frame = CGRectMake(Screen_Width-perWidth, 0, perWidth, 44);
    payBtn.backgroundColor = [UIColor yellowColor];
    payBtn.titleLabel.textAlignment = 1;
    payBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [totalBar addSubview:payBtn];
    [payBtn setTitle:@"提交订单" forState:0];
    [payBtn setTitleColor:[UIColor blackColor] forState:0];
    [payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)payAction:(UIButton *)sender{
    
}

#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AddressPayCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressReuser];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 1){
        GoodsPayCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsPayReuser];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }else if (indexPath.section == 2){
        HowToPayCell *cell = [tableView dequeueReusableCellWithIdentifier:HowToPayReuser];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }else{
        PricePayCell *cell = [tableView dequeueReusableCellWithIdentifier:PricePayReuser];
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 80;
    }else if(indexPath.section == 1){
        return 96;
    }else if (indexPath.section == 2){
        return 60;
    }else{
        return 70;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
