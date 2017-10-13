//
//  AddressEditVC.m
//  ZGSTApp
//
//  Created by tusm on 15/12/24.
//  Copyright © 2015年 fady. All rights reserved.
//

#import "AddressEditVC.h"

#define CellId @"cellId"

#import "AddressPayCell.h"
#import "AddNewAddressVC.h"

@interface AddressEditVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *addBar;
    
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation AddressEditVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self addBarLayout];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [addBar removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.title = @"管理收货地址";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tabBarController.tabBar.hidden = YES;
    
    [self tableViewLayout];
    [self initNavigationBar];
    
}

-(void)initNavigationBar{
    //
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    cancelBtn.frame = CGRectMake(0, 0, 40, 30);
    
    [cancelBtn setTitle:@"编辑" forState:0];
    
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    
    [cancelBtn addTarget:self action:@selector(editsAction) forControlEvents:UIControlEventTouchUpInside];
    
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    
    self.navigationItem.rightBarButtonItem = right;
    
}

-(void)tableViewLayout{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"AddressPayCell" bundle:nil] forCellReuseIdentifier:CellId];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(void)addBarLayout{
    
    addBar = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-44, Screen_Width, 44)];
    addBar.backgroundColor = [UIColor whiteColor];
    
    [self.tabBarController.view addSubview:addBar];
    
    UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2-50, 7, 100, 30)];
    totalLabel.text = @"添加收货地址";
    totalLabel.textAlignment = 1 ;
    totalLabel.textColor = [UIColor darkGrayColor];
    totalLabel.font = [UIFont boldSystemFontOfSize:15];
    [addBar addSubview:totalLabel];
    //添加点击事件
    UITapGestureRecognizer *tapAddViewGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAddAction:)];
    addBar.userInteractionEnabled = YES;
    [addBar addGestureRecognizer:tapAddViewGes];
    
}
#pragma mark----action
-(void)editsAction{
    
    
}

-(void)tapAddAction:(UITapGestureRecognizer *)sender{
    
    AddNewAddressVC *addNewVC = [[AddNewAddressVC alloc]init];
    
    [self.navigationController pushViewController:addNewVC animated:YES];
    
}
#pragma mark----tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressPayCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //去除粘性
    CGFloat sectionHeaderHeight = 15;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
}

@end
